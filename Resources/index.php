<html>
 <head>
   <script>
function callObjc(functionname,arg){
var rootElm = document.documentElement;
    var newFrameElm = document.createElement("IFRAME");
    newFrameElm.setAttribute("src","kamy:"+functionname+":"+arg);
    rootElm.appendChild(newFrameElm);
    //remove the frame now
    newFrameElm.parentNode.removeChild(newFrameElm);
};
</script>
  <title>PHP Test</title>
 </head>
 <body>
<a onclick="callObjc('getPHPOutput','phpinfo.php');"> <?php echo "Click Here"; ?> </a>
 </body>
</html>