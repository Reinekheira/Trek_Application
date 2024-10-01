#!/bin/bash
# Information searching project
public_ip() {
    echo "The public IP address is $(curl -s ifconfig.me)"
}
private_ip() {
    echo "The private IP address is $(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}')"
}
check_cpu() {
    echo "$(ps -eo pid,%cpu,cmd --sort=-%cpu | head -6 | tail -n +2)"
    echo "***********************************************************"
    echo -e "\n"
}
check_disk() {
    echo -e "The disk usage is:\n $(df -h)"
}
check_running_service() {
    echo "$(systemctl list-units --type=service --state=running)"
}
list_top_file() {
    echo -e "List of 10 largest files in /home:\n"
    echo "$(du -ah /home | sort -rh | head -n 10)"
}
check_mac() {
    echo -e "The MAC address is $(ifconfig | grep 'ether' | awk '{print $2}')"
}
echo "Please input needed option:"
echo "P: Checking the public IP address"
echo "IP: Checking your Private IP"
echo "DISK: Checking the disk usage"
echo "CPU: Checking the CPU usage"
echo "Service: Checking running services"
echo "Top: Top 10 Largest Files in /home"
echo "MAC: Checking the MAC address of your PC"
echo "ALL: Full information"
echo "**********************************************"
read -p "Enter your choice: " choice
case $choice in
    p|P)
        public_ip
        ;;
    ip|IP)
        private_ip
        ;;
    disk|DISK)
        check_disk
        ;;
    cpu|CPU)
        check_cpu
        ;;
    service|SERVICE)
        check_running_service
        ;;
    top|TOP)
        list_top_file
        ;;
    mac|MAC)
        check_mac
        ;;
    all|ALL)
        public_ip
        echo "***********************************************************"
        private_ip
        echo "***********************************************************"
        check_cpu
        echo "***********************************************************"
        check_disk
        echo "***********************************************************"
        echo -e "\n"
        check_mac
        echo "***********************************************************"
        echo -e "\n"
        check_running_service
        ;;
    *)
        echo "Invalid choice."
        ;;
esac