#!/bin/bash
# Colors for better display
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Kiểm tra quyền root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}❌ Script này cần chạy với quyền root. Vui lòng sử dụng sudo hoặc tài khoản root.${NC}"
    exit 1
fi

# Kiểm tra hệ điều hành
if ! command -v apt >/dev/null 2>&1; then
    echo -e "${RED}❌ Script này chỉ hỗ trợ hệ điều hành dựa trên Debian/Ubuntu.${NC}"
    exit 1
fi

# Kiểm tra wget hoặc curl
if ! command -v wget >/dev/null 2>&1 && ! command -v curl >/dev/null 2>&1; then
    echo -e "${RED}❌ Yêu cầu cài đặt wget hoặc curl. Đang cài đặt...${NC}"
    if ! apt update && apt install -y wget curl; then
        echo -e "${RED}❌ Lỗi khi cài đặt wget/curl${NC}"
        exit 1
    fi
fi

# Kiểm tra kết nối Internet
if ! ping -c 1 google.com >/dev/null 2>&1; then
    echo -e "${RED}❌ Không có kết nối Internet. Vui lòng kiểm tra mạng và thử lại.${NC}"
    exit 1
fi

# Hiển thị logo và thông tin
echo -e "${CYAN}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${WHITE} ${CYAN}║${NC}"
echo -e "${CYAN}║${RED} ███ ${YELLOW}███ ${GREEN}███ ${BLUE}███ ${PURPLE}███ ${WHITE}███ ${CYAN}███ ${RED}███ ${YELLOW}███ ${CYAN}║${NC}"
echo -e "${CYAN}║${RED} █ ${YELLOW}█ ${GREEN}█ █ ${BLUE}█ █ ${PURPLE}█ ${WHITE}█ ${CYAN}█ ${RED}█ ${YELLOW}█ ${CYAN}║${NC}"
echo -e "${CYAN}║${RED} ███ ${YELLOW}███ ${GREEN}███ ${BLUE}███ ${PURPLE}███ ${WHITE}███ ${CYAN}█ ${RED}███ ${YELLOW}███ ${CYAN}║${NC}"
echo -e "${CYAN}║${RED} █ ${YELLOW} █ ${GREEN}█ █ ${BLUE}█ █ ${PURPLE}█ ${WHITE} █ ${CYAN}█ ${RED}█ ${YELLOW}█ ${CYAN}║${NC}"
echo -e "${CYAN}║${RED} ███ ${YELLOW}███ ${GREEN}█ █ ${BLUE}███ ${PURPLE}███ ${WHITE}███ ${CYAN}███ ${RED}███ ${YELLOW}███ ${CYAN}║${NC}"
echo -e "${CYAN}║${WHITE} ${CYAN}║${NC}"
echo -e "${CYAN}║${WHITE} ⚡ ${YELLOW}S2CODETAEM ${RED}★ ${BLUE}HTTP PROXY INSTALLER ${WHITE}⚡ ${CYAN}║${NC}"
echo -e "${CYAN}║${WHITE} ${GREEN}🚀 Developed by TẠ NGỌC LONG - Premium Solutions 🚀 ${CYAN}║${NC}"
echo -e "${CYAN}║${WHITE} ${CYAN}║${NC}"
echo -e "${CYAN}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""

# Thông tin liên hệ
echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${WHITE} 📞 LIÊN HỆ: ${CYAN}FB: s2code08122000 ${WHITE}│ ${CYAN}TG: @S2codetaem48 ${WHITE}│ ${CYAN}Services: Cloud/MMO/Tools${BLUE}║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Hướng dẫn sử dụng
echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║${WHITE} ⚠️ QUAN TRỌNG: ${RED}Mở port 6969 ${WHITE}trước khi chạy script │ ${GREEN}Proxy: tangoclong:08122000${YELLOW}║${NC}"
echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Kiểm tra port 6969
if ! netstat -tuln | grep -q ":6969 "; then
    echo -e "${RED}❌ Port 6969 chưa được mở. Đang thử mở port...${NC}"
    if ! ufw allow 6969 >/dev/null 2>&1; then
        echo -e "${YELLOW}⚠️ Không thể mở port 6969 qua ufw. Vui lòng kiểm tra firewall của nhà cung cấp VPS.${NC}"
    fi
fi

# Xác thực mật khẩu
echo -e "${PURPLE}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║${WHITE} XÁC THỰC MẬT KHẨU ${PURPLE}║${NC}"
echo -e "${PURPLE}╠═══════════════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${PURPLE}║${YELLOW} 🔑 Vui lòng nhập mật khẩu để tiếp tục (mật khẩu mặc định: 08122000) ${PURPLE}║${NC}"
echo -e "${PURPLE}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

max_attempts=5
attempt=0
while [ $attempt -lt $max_attempts ]; do
    read -p "➤ Nhập mật khẩu: " -s password </dev/tty
    echo ""
    if [ "$password" = "08122000" ]; then
        echo -e "${GREEN}✅ Mật khẩu đúng! Đang tiếp tục...${NC}"
        break
    else
        echo -e "${RED}❌ Mật khẩu sai! Vui lòng thử lại.${NC}"
        attempt=$((attempt + 1))
        if [ $attempt -eq $max_attempts ]; then
            echo -e "${RED}❌ Đã vượt quá số lần thử. Thoát script.${NC}"
            exit 1
        fi
    fi
done

# Xác nhận Y/N
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${WHITE} Bạn đã mở port 6969 và sẵn sàng cài đặt HTTP proxy? ${YELLOW}[Y/N]${GREEN}║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

max_attempts=5
attempt=0
while [ $attempt -lt $max_attempts ]; do
    read -p "➤ Nhập [Y] để tiếp tục hoặc [N] để thoát: " -i Y confirm_ready </dev/tty
    case "${confirm_ready,,}" in
        y|yes)
            echo -e "${GREEN}✅ Đang bắt đầu cài đặt HTTP proxy...${NC}"
            echo ""
            break
            ;;
        n|no)
            echo -e "${RED}❌ Đã hủy! Vui lòng mở port 6969 rồi chạy lại script.${NC}"
            exit 0
            ;;
        *)
            echo -e "${YELLOW}⚠️ Vui lòng nhập Y hoặc N${NC}"
            attempt=$((attempt + 1))
            if [ $attempt -eq $max_attempts ]; then
                echo -e "${RED}❌ Đã vượt quá số lần thử. Thoát script.${NC}"
                exit 1
            fi
            ;;
    esac
done

# Xác thực tên khách hàng
echo -e "${PURPLE}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║${WHITE} XÁC THỰC THÔNG TIN ${PURPLE}║${NC}"
echo -e "${PURPLE}╠═══════════════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${PURPLE}║${YELLOW} 👤 Vui lòng nhập họ và tên đầy đủ của bạn để tiếp tục ${PURPLE}║${NC}"
echo -e "${PURPLE}║${YELLOW} ⚠️ Lưu ý: Tên phải là tên thật (Họ + Tên), không được để trống ${PURPLE}║${NC}"
echo -e "${PURPLE}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

attempt_count=0
while true; do
    attempt_count=$((attempt_count + 1))
    read -p "➤ Nhập họ và tên đầy đủ: " client_full_name </dev/tty
    if [ $attempt_count -eq 1 ]; then
        if echo "$client_full_name" | grep -qE "^[A-Za-zÀ-ỹ[:space:]]+$" && [ $(echo "$client_full_name" | wc -w) -ge 2 ] && ! echo "${client_full_name,,}" | grep -qE "test test|abc xyz|nguyen van a|tran thi b|le van c|admin user|user name|full name"; then
            echo -e "${GREEN}✅ Tên hợp lệ! Xin chào $client_full_name${NC}"
            break
        else
            echo -e "${RED}❌ Tên không hợp lệ! Vui lòng nhập họ và tên đầy đủ (ít nhất 2 từ, không chứa số hoặc ký tự đặc biệt)${NC}"
            echo -e "${YELLOW}💡 Ví dụ: Nguyễn Văn An, Trần Thị Hoa...${NC}"
            echo ""
        fi
    else
        if [ -n "$client_full_name" ] && [ ${#client_full_name} -ge 2 ]; then
            echo -e "${GREEN}✅ Cảm ơn $client_full_name! Đang tiếp tục...${NC}"
            break
        else
            echo -e "${RED}❌ Vui lòng không để trống tên!${NC}"
            echo ""
        fi
    fi
done

echo ""
echo -e "${PURPLE}🚀 Chào mừng $client_full_name! Đang khởi động HTTP Proxy Installer...${NC}"
echo ""
sleep 2

# Bắt đầu cài đặt
echo -e "${PURPLE}🚀 Bắt đầu cài đặt HTTP Proxy Server...${NC}"
echo ""

# 1. Cài đặt các gói
echo "[1/5] ➤ Đang cập nhật và cài đặt các gói..."
if ! apt update || ! apt upgrade -y || ! apt install -y squid vim apache2-utils; then
    echo -e "${RED}❌ Lỗi khi cập nhật hoặc cài đặt các gói${NC}"
    exit 1
fi

# 2. Xóa và tạo file cấu hình Squid
echo "[2/5] ➤ Đang xóa và tạo file cấu hình Squid..."
rm -f /etc/squid/squid.conf
cat <<EOF >/etc/squid/squid.conf
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwords
auth_param basic realm proxy
acl authenticated proxy_auth REQUIRED
http_access allow authenticated
http_port 6969
EOF

# 3. Tạo tài khoản proxy
echo "[3/5] ➤ Tạo tài khoản proxy VIP..."
squid_user="tangoclong"
squid_pass="08122000"
echo "$squid_pass" | htpasswd -c -i /etc/squid/passwords "$squid_user"

# 4. Khởi động lại dịch vụ Squid
echo "[4/5] ➤ Khởi động lại dịch vụ Squid..."
if ! systemctl restart squid.service || ! systemctl enable squid.service; then
    echo -e "${RED}❌ Lỗi: Không thể khởi động dịch vụ Squid${NC}"
    journalctl -u squid.service --no-pager | tail -n 10
    exit 1
fi

# Kiểm tra dịch vụ
sleep 3
if systemctl is-active --quiet squid.service; then
    echo "[5/5] ✅ Squid service đã khởi động thành công"
else
    echo -e "${RED}❌ Lỗi: Squid service không khởi động được${NC}"
    journalctl -u squid.service --no-pager | tail -n 10
    exit 1
fi

# Kiểm tra IP
echo -e "${CYAN}🔍 Đang kiểm tra IP...${NC}"
ip_address=$(curl -s --connect-timeout 10 ipinfo.io/ip || echo "N/A")
if [ "$ip_address" = "N/A" ]; then
    echo -e "${RED}❌ Không thể lấy địa chỉ IP${NC}"
    exit 1
fi

# Lấy thông tin IP
echo -e "${CYAN}📡 Đang lấy thông tin IP...${NC}"
ip_info=$(curl -s --connect-timeout 10 "http://ip-api.com/json/$ip_address" || echo "{}")
isp=$(echo "$ip_info" | grep -o '"isp":"[^"]*"' | cut -d'"' -f4 || echo "N/A")
country=$(echo "$ip_info" | grep -o '"country":"[^"]*"' | cut -d'"' -f4 || echo "N/A")

# Kiểm tra proxy
echo -e "${CYAN}🔧 Đang kiểm tra HTTP proxy...${NC}"
proxy_status="HTTP Proxy ❌ (không thể kết nối)"
for endpoint in "http://icanhazip.com" "http://ifconfig.me/ip" "http://checkip.amazonaws.com"; do
    if curl -s -o /dev/null -w "%{http_code}" --proxy "http://$squid_user:$squid_pass@$ip_address:6969" "$endpoint" --connect-timeout 10 --max-time 15 | grep -q "200"; then
        proxy_status="HTTP Proxy ✅ (tested with $endpoint)"
        break
    fi
done

# Hiển thị thông tin proxy
echo -e "${GREEN}✅ Cài đặt HTTP Proxy VIP thành công cho $client_full_name!${NC}"
echo -e "${PURPLE}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║${WHITE} THÔNG TIN HTTP PROXY VIP - $client_full_name${PURPLE}║${NC}"
echo -e "${PURPLE}╠═══════════════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${PURPLE}║${CYAN} 🌐 HTTP Proxy URL: ${WHITE}http://$squid_user:$squid_pass@$ip_address:6969 ${PURPLE}║${NC}"
echo -e "${PURPLE}║${CYAN} 📍 Địa chỉ IP: ${WHITE}$ip_address ${PURPLE}║${NC}"
echo -e "${PURPLE}║${CYAN} 🔌 Cổng: ${WHITE}6969 ${PURPLE}║${NC}"
echo -e "${PURPLE}║${CYAN} 👤 Username: ${WHITE}$squid_user ${PURPLE}║${NC}"
echo -e "${PURPLE}║${CYAN} 🔑 Password: ${WHITE}$squid_pass ${PURPLE}║${NC}"
echo -e "${PURPLE}║${CYAN} 🏢 Nhà mạng: ${WHITE}$isp ${PURPLE}║${NC}"
echo -e "${PURPLE}║${CYAN} 🌍 Quốc gia: ${WHITE}$country ${PURPLE}║${NC}"
echo -e "${PURPLE}║${CYAN} 🔧 Trạng thái: ${WHITE}$proxy_status ${PURPLE}║${NC}"
echo -e "${PURPLE}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"

# Thông tin liên hệ
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║${WHITE} THÔNG TIN NHÀ PHÁT TRIỂN ${GREEN}║${NC}"
echo -e "${GREEN}╠═══════════════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${GREEN}║${YELLOW} 👨‍💻 Nhà phát triển: ${WHITE}TẠ NGỌC LONG ${GREEN}║${NC}"
echo -e "${GREEN}║${YELLOW} 🌐 Chuyên cung cấp tài khoản Google Cloud số lượng lớn ${GREEN}║${NC}"
echo -e "${GREEN}║${YELLOW} 🎮 Chuyên cung cấp các mặt hàng MMO ${GREEN}║${NC}"
echo -e "${GREEN}║${YELLOW} 🔗 Chuyên cung cấp tài nguyên Proxy, tài khoản các loại ${GREEN}║${NC}"
echo -e "${GREEN}║${YELLOW} 💻 Nhận tạo Tools, tạo Web, code phần mềm theo nhu cầu ${GREEN}║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${WHITE} LIÊN HỆ ${BLUE}║${NC}"
echo -e "${BLUE}╠═══════════════════════════════════════════════════════════════════════════════╣${NC}"
echo -e "${BLUE}║${CYAN} 📘 Facebook 1: ${WHITE}https://www.facebook.com/s2code08122000/ ${BLUE}║${NC}"
echo -e "${BLUE}║${CYAN} 📘 Facebook 2: ${WHITE}https://www.facebook.com/tangoclongmeta ${BLUE}║${NC}"
echo -e "${BLUE}║${CYAN} 📱 Telegram: ${WHITE}https://t.me/S2codetaem48 ${BLUE}║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}🎉 Cảm ơn bạn đã sử dụng dịch vụ của S2CODE TEAM! 🎉${NC}"
echo -e "${YELLOW}💡 Nếu cần hỗ trợ, vui lòng liên hệ qua các kênh trên! 💡${NC}"
