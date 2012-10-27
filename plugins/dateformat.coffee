month = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]

module.exports = (date, format)->
  yyyy = date.getFullYear()
  mm = date.getMonth()+1
  if mm < 10 then mm = "0"+mm
  dd = date.getDate()
  if dd < 10 then dd = "0"+dd
  HH = date.getHours()
  if HH < 10 then HH = "0"+HH
  MM = date.getMinutes()
  if MM < 10 then MM = "0"+MM
  ss = date.getSeconds()
  if ss < 10 then ss = "0"+ss
  return format.replace("yyyy", yyyy).replace("mmm", month[mm-1]).replace("mm", mm).replace("dd", dd).replace("HH", HH).replace("MM", MM).replace("ss", ss)

  
