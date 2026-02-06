MS_TOOLS_ROOT="/opt/mssql-tools/bin"

if [ -s $MS_TOOLS_ROOT ]; then
    export PATH="$PATH:/opt/mssql-tools/bin"
fi