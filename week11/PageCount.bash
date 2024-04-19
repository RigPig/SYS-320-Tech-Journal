PageCount() {
    local file="/var/log/apache2/access.log"
    local index_count=$(grep -c "GET /index.html " "$file")
    local page1_count=$(grep -c "GET /page1.html " "$file")
    local page2_count=$(grep -c "GET /page2.html " "$file")
   
    echo "index.html accessed $index_count times"
    echo "page1.html  accessed $page1_count times"
    echo "page2.html accessed  $page2_count times"
}
PageCount
