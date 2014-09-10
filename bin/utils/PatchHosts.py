#!/usr/bin/python
# -*- coding: UTF-8 -*-

"""
Usage: update-dotdee FILENAME

Generate a (configuration) file based on the contents of the files in the
directory with the same name as FILENAME but ending in '.d'.

If FILENAME exists but the corresponding directory does not exist yet, the
directory is created and FILENAME is moved into the directory so that its
existing contents are preserved.
"""

# Semi-standard module versioning.
__version__ = '1.0.10'


import os
import re
import webbrowser
import sys
import tempfile
# from ConfigParser import ConfigParser


eol = os.linesep

try:
    act = sys.argv[1]
except Exception, e:
    print "Ну охуеть теперь параметров нет!"
    sys.exit(1)

# if hasattr(sys, "frozen") and sys.frozen in ("windows_exe", "console_exe"):
#     current_dir = os.path.dirname(sys.executable)
# else:
#     current_dir = os.path.dirname(os.path.realpath(__file__))
# params_paths = (
#     os.path.abspath(current_dir + "/params.ini"),
#     os.path.abspath(current_dir + "/../../params.ini"),
# )


params_default = {
    "vhosts_section_id": "Vagrant hosts",
    "www_dir": "Z:\srv",
    "www": "/var/www",
    "server_ip": "192.168.33.10",
}



def main():
    print "Action: {0}".format(act)
    sys.exit(1)

    params = get_params()
    hosts_path = check_files()

    # print "hosts_path: {0} {1}".format(hosts_path, server_ip)
    # print "params: {0} {1} {2}".format(params["vhosts_section_id"], params["www_dir"], params["server_ip"])
    
    # hosts = get_virtual_hosts_names(params)
    hosts = get_virtual_hosts_remote_names(params)
    hosts_content = get_hosts_file_content(hosts_path, hosts, params)

    print "hosts: {0}".format(hosts)

    try:
        open(hosts_path, "w").write(hosts_content)
        os.system("ssh vagrant sudo update-apache-vhosts")
    except IOError as e:
        fd, tmp_file_path = tempfile.mkstemp(".txt")
        os.close(fd)
        open(tmp_file_path, "w").write(hosts_content)

        print "Can't write hosts file: {0}{2}Look what you need in the file {1}".format(e, tmp_file_path, eol)
        webbrowser.open(tmp_file_path)
        raw_input("Press Enter to exit...")


def check_files():
    if sys.platform == "win32":
        windows_dir = os.environ.get("SystemRoot", r"C:\Windows")
        hosts_path = windows_dir + r"\system32\drivers\etc\hosts"
    else:
        hosts_path = "/etc/hosts"

    if not os.path.isfile(hosts_path):
        raise RuntimeError("Hosts file not found")
    if not os.access(hosts_path, os.R_OK):
        raise RuntimeError("Hosts file is not readable")

    return hosts_path


def get_params():
    params = params_default
    # os.system("vagrant ssh -c '/usr/local/sbin/sshc' > tmp.txt")
    os.system("vagrant ssh -c \"ip route | grep eth1 | sed 's/.* src \(.*\)/\1/' \" > tmp.txt");

    params["server_ip"] = open('tmp.txt', "r").read().strip()
    print "Ip: {0} {1}" .format(params["server_ip"],  eol)
    os.system("rm tmp.txt")

    return params


def get_virtual_hosts_names(params):
    hosts = []
    www_dir = os.path.expanduser(params["www_dir"])

    for name in os.listdir(www_dir):
        if os.path.isdir(os.path.join(www_dir, name)):
            hosts.append(name)
    return hosts


def get_virtual_hosts_remote_names(params):
    hosts = []
    os.system("ssh vagrant ls /var/www > tmp.txt")
    hosts_string = open('tmp.txt', "r").read()
    os.system("rm tmp.txt")
    hosts = hosts_string.splitlines()

    return hosts


def get_hosts_file_content(hosts_path, hosts, params):
    hosts_content = open(hosts_path, "r").read()
    our_pattern = r"#(\r?\n)+#{id}\s+begin.+?#{id}\s+end(\r?\n)+#".format(id=params["vhosts_section_id"])
    hosts_content = re.sub(our_pattern, "", hosts_content, flags=re.DOTALL)
    hosts_content = hosts_content.strip()

    our_section = "{0}{0}#{0}#{id} begin{0}#{0}".format(eol, id=params["vhosts_section_id"])
    for host in hosts:
        our_section += "{0}\t{1}.loc{2}".format(params["server_ip"], host, eol)
        our_section += "{0}\t{1}.loc{2}".format(params["server_ip"], "www." + host, eol)
    our_section += "#{0}#{id} end{0}#{0}".format(eol, id=params["vhosts_section_id"])
    hosts_content += our_section

    return hosts_content


if __name__ == "__main__":
    try:
        main()
    except BaseException as e:
        print "Error: {0}".format(e)
        raw_input("Press Enter to exit...")
