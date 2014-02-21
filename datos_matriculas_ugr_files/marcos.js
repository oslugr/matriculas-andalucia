var altoIFrame=300;
var currentPage=1;

jQuery().ready(function (){

	var altoCabecera=94;
	var paddingGeneral=25+25;
	var altoPie=56;
	var altoTotal=$(window).height();
	altoIFrame=altoTotal-altoCabecera-paddingGeneral-altoPie;
	if (altoIFrame<365)
		altoIFrame=365;

	$("#iframe_ai").css("height",altoIFrame);
	// Al cargar una página en el iframe, recalcula su altura, y da valores a los botones de ayuda y contacto
	$("#iframe_ai").load(function (){
		$("#ai_menu_ayuda").hide();
		$("#ai_menu_contacto").hide();
		$("#ai_menu_boton1").hide();
		$("#ai_menu_boton2").hide();
		$("#ai_menu_boton3").hide();

		$(".__ai_miga").css("height","20px");
		$(".__ai_fecha").css("height","16px");
		$(".__ai_fecha").css("padding","4px 0 0 3px");
		$("#contenedor_div_iframe").css("height","20px");

		redimensionaIframe();
		
		if ($("#iframe_ai").contents().find(".__ai_ayuda").attr("href")!=null) {
			$("#iframe_ai").contents().find(".__ai_ayuda").css("visibility","hidden");
			$("#ai_menu_ayuda").show();
			$(".__ai_boton_ayuda").click(function(){
				var hrefayuda=$("#iframe_ai").contents().find(".__ai_ayuda").attr("href");
				$.fancybox({
					  href:hrefayuda,
					  type:'iframe',
					  width:895,
					  height:altoIFrame+100
				  });
				return false;
			});
		}
		if ($("#iframe_ai").contents().find(".__ai_contacto").attr("href")!=null) {
			$("#iframe_ai").contents().find(".__ai_contacto").css("visibility","hidden");
			$("#ai_menu_contacto").show();
			$(".__ai_boton_contacto").click(function(){
	        	var ancho=parseInt($("#iframe_ai").contents().find(".__ai_contacto").attr("__ai_ancho"));
	        	var alto=parseInt($("#iframe_ai").contents().find(".__ai_contacto").attr("__ai_alto"));
	        	if (isNaN(ancho))
	        		ancho=450;
	        	if (isNaN(alto))
	        		alto=220;
				var hrefayuda=$("#iframe_ai").contents().find(".__ai_contacto").attr("href");
				$.fancybox({
					  href:hrefayuda,
					  type:'iframe',
					  width:ancho,
					  height:alto
				  });
				return false;
			});
		}

		for (i=1;i<4;i++){
			if ($("#iframe_ai").contents().find(".__ai_boton"+i).attr("href")!=null) {
				$("#iframe_ai").contents().find(".__ai_boton"+i).css("visibility","hidden");
				var aTitle=$("#iframe_ai").contents().find(".__ai_boton"+i).attr("title");
				var texto=$("#iframe_ai").contents().find(".__ai_boton"+i).text();
				$(".__ai_boton"+i).attr("title",aTitle);
				$(".__ai_boton"+i).val(texto);
				$("#ai_menu_boton"+i).show();
				$(".__ai_boton"+i).click(function(){
					var i=3;
					if ($(this).hasClass("__ai_boton1")) 
						i=1;
					if ($(this).hasClass("__ai_boton2"))
						i=2;
					var ancho=parseInt($("#iframe_ai").contents().find(".__ai_boton"+i).attr("__ai_ancho"));
					var alto=parseInt($("#iframe_ai").contents().find(".__ai_boton"+i).attr("__ai_alto"));
					if (isNaN(ancho))
						ancho=800;
					if (isNaN(alto))
						alto=600;
					var hrefayuda=$("#iframe_ai").contents().find(".__ai_boton"+i).attr("href");
					$.fancybox({
						href:hrefayuda,
						type:'iframe',
						width:ancho,
						height:alto
					});
					return false;
				});
			}
		}

		if ($("#iframe_ai").contents().find(".__ai_miga").attr("class")!=null) {
			$("#iframe_ai").contents().find(".__ai_miga").css("visibility","hidden");
			$("#iframe_ai").contents().find(".__ai_miga").css("height","0");
			$(".__ai_miga").html($("#iframe_ai").contents().find(".__ai_miga").html());
		}
		else
			$(".__ai_miga").html("");
		if ($("#iframe_ai").contents().find(".__ai_fecha")!=null) {
			$("#iframe_ai").contents().find(".__ai_fecha").css("visibility","hidden");
			$("#iframe_ai").contents().find(".__ai_fecha").css("height","0");
			$(".__ai_fecha").html($("#iframe_ai").contents().find(".__ai_fecha").html());
		}
		else
			$(".__ai_fecha").html("");
		
		//Asignamos una ventana fancy a todos los elementos de clase __ai_fancybox que haya en el iframe
		asociaFancy();

		$( "[title]").tooltip({  
		    delay: 500, 
		    showURL: false,
		    position: { my: "left+65 top", at: "right center" },
		    extraClass: "pretty"
	    });


	});
});

function asociaFancy(){
	$("#iframe_ai").contents().find('.__ai_fancybox').click(function() {
    	var enlace=$(this).attr("href");
    	var ancho=parseInt($(this).attr("__ai_ancho"));
    	var alto=parseInt($(this).attr("__ai_alto"));
    	if (isNaN(ancho))
    		ancho=800;
    	if (isNaN(alto))
    		alto=600;
    	window.parent.$.fancybox({
    			  href:enlace,
    			  type:'iframe',
    			  width:ancho,
    			  height:alto
     	});
  	    return false;
     });
}

function redimensionaIframe(){
	var altoInteriorIframe=altoIFrame;
	if (!$("#iframe_ai").contents().find("body").hasClass("__ai_alto_fijo")) {
	
		var altoInteriorIframe=$("#iframe_ai").contents().height();
		if (altoInteriorIframe<altoIFrame)
			altoInteriorIframe=altoIFrame;
	}
	$("#iframe_ai").height(altoInteriorIframe+1);
}


