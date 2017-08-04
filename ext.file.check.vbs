'文件检查

if WScript.Arguments.count=0 then
	wscript.echo "Use ext.file.checks.vbs file type"
	wscript.quit
else
'	wscript.echo WScript.Arguments(0)
end if
file_path=WScript.Arguments(0)
date1=date()
yyyy=year(date1)
mm=month(date1)
dd=day(date1)

if mm=10 then m="a"
if mm=11 then m="b"
if mm=12 then m="c"
if mm<10 then m=cstr(mm)
if mm>9 then 
	M=cstr(mm)
else 
	M=right(mm,1)
end if
if dd> 9 then
	D=cstr(dd)
else
	D=right(dd,1)
end if

if weekday(date1)=6 then
	date2=dateadd("d",3,date1)
else
	date2=dateadd("d",1,date1)
end if

file_path=replace(file_path,"'","")
file_path=replace(file_path,"{yyyymmdd}",cstr(yyyy)+cstr(right("0"&mm,2))+cstr(right("0"&dd,2)))
file_path=replace(file_path,"{yyyy-mm-dd}",cstr(yyyy)+"-"+cstr(right("0"&mm,2))+"-"+cstr(right("0"&dd,2)))
file_path=replace(file_path,"{yyyy-M-D}",cstr(yyyy)+"-"+M+"-"+D)
file_path=replace(file_path,"{mdd}",m+cstr(right("0"&dd,2)))
file_path=replace(file_path,"{Mdd}",M+cstr(right("0"&dd,2)))
file_path=replace(file_path,"{mmdd}",cstr(right("0"&mm,2))+cstr(right("0"&dd,2)))
file_path=replace(file_path,"{yyyymmdd++}",CStr(Year(date2))&Right("0"&Month(date2),2)&Right("0"&Day(date2),2))

if WScript.Arguments.count>2 then
  wscript.echo file_path
end if

return_code=""
Set fso = CreateObject("Scripting.FileSystemObject")
if WScript.Arguments(1)="1" then
	if fso.fileexists(file_path) then
		return_code="1" 
	else
		return_code="0"
	end if
end if
if WScript.Arguments(1)="2" then
	if fso.fileexists(file_path) then
		return_code=fso.GetFile(file_path).Size
	else
		return_code="0"
	end if
end if
if WScript.Arguments(1)="3" then
	if fso.fileexists(file_path) then
		return_code=fso.GetFile(file_path).DateLastModified
	else
		return_code="0"
	end if
end if

wscript.echo return_code

if WScript.Arguments.count>2 then
	set f =fso.opentextfile("c:\zabbix_agentd.log",8)
	f.writeline date()&" "&time()&" "&file_path&" "&return_code
	f.close
end if

function chinese2unicode(Str)
  dim i
  dim Str_one
  dim Str_unicode
  if(isnull(Str)) then
     exit function
  end if
  for i=1 to len(Str)
    Str_one=Mid(Str,i,1)
    Str_unicode=Str_unicode&chr(38)
    Str_unicode=Str_unicode&chr(35)
    Str_unicode=Str_unicode&chr(120)
    Str_unicode=Str_unicode& Hex(ascw(Str_one))
    Str_unicode=Str_unicode&chr(59)
  next
  chinese2unicode=Str_unicode
end function   