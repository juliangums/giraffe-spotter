import 'dart:convert';
import 'dart:io';

import 'package:giraffe_spotter/models/Elementation.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';
// ignore: implementation_imports
import 'package:xml/src/xml/utils/node_list.dart';
import 'package:giraffe_spotter/utils/Extensions.dart';


// contains most of the logic behind xml 2 json ... enjoy ;)
class XmlHandler{

   //convert xml to json
   static xmlToJsonConverter(response){
    //convert to json from xml
    final myTransformer = Xml2Json();
    //transform the data
    myTransformer.parse(response.toString().trim());
    final gData = myTransformer.toGData();
    final decoded = json.decode(gData);
    return WelcomeJson.fromJson(decoded);
  }

   //extract content from the xml tags
   static xmlExtractor(String xmlJson,{bool require = false,bool element = false, bool urlLaunch = false}){

    //  to avoid tag repetition
    List<Elementation> xmlParent = [];
    //create list of the xml tags
    List<String> xmlElement = [];
    //img list
    List<String> images = [];
    //aHref List
    List<String> aHref = [];

    int i = 0;

    XmlDocument document;

    Map<String,String> aElements = {};

    List<Map<String,String>> aUrlLink = [];

    //checking for iFrames...
    document = xmlResponse(xmlJson);

     //to retrieve the tag structure and img
     document.descendants.map((e) => e.children).forEach(
             (element) {
           //condition to ignore empty tags
           if(element.isNotEmpty){
             try{
               //to retrieve parent node in each child node
               element.map((e) => e.parentElement).forEach((element)
               {
                 if(!xmlParent.contains(Elementation(element!.name.toString(), element)))
                 {
                   xmlParent.add(Elementation(element.name.toString(),element));

                   //condition to check <a>....
                   if(element.name.toString() == 'a'){
                     aElements.putIfAbsent(element.text.toString(), () => element.attributes.length>1? decode(element.attributes, 'href').toString(): element.attributes[0].value.toString());
                     xmlElement.add('a');
                   }
                   //find the images position in the structure
                    if(element.name.toString() == 'div' && element.firstElementChild!.name.toString() == 'img'){
                     final img = element.findAllElements('img');
                     img.map((e) => e.attributes).forEach((element)
                     {
                       images.add(decode(element,'src'));
                     });
                     //add img to the array  node structure
                     xmlElement.add('img');
                   }
                   // add the tag name at this point
                    if( element.name.toString()!= 'div' && element.name.toString()!= 'em' &&
                       element.name.toString() != 'ol' && element.name.toString()!= 'span'
                       && element.name.toString() != 'ul'
                        //&& element.name.toString()!= 'blockquote'
                       && element.name.toString()!= 'strong' && element.name.toString()!= 'a')
                     xmlElement.add(element.name.toString());
                 }
               });
             }catch (e){}
           }});
     aUrlLink.add(aElements);
     //add other tags in the xmlElement list;
     final List<Map<String,List<String>>> xmlFinally = xmlNodeText(xmlElement, xmlDocument: document,xmlImages: images,xmlA: aHref);
     xmlElement.map((e) => e ).forEach((element){i++;});
     //condition to return list or length
     return urlLaunch == false ?element == false? require == true ? xmlFinally : i : xmlElement: aUrlLink;
  }

  //Check the XmlDocument response, to determine if it opens urlLaunch or articlePage :)
   static xmlResponse(String xmlJson){
     XmlDocument document;
     try{
       //adding tags to make the string syntax complete ...
       final finalJson =  '<div>'+xmlJson+'''</div>''';
     return  document = XmlDocument.parse(finalJson);
     }
     catch(e){
       try{
         //check if the xml contains youtube video ::::<iframe></iframe>
         final finalJson = '<div>'+iFrameExtractor(xmlJson)+'</div>';
        return document = XmlDocument.parse(finalJson);
       }catch(e){
         try{
           //check if </p> is missing and add it.
           final finalJson = '<div>'+iFrameExtractor(pClosingHandler(xmlJson))+'</div>';
           return document = XmlDocument.parse(finalJson);
         }catch(e){
           //the return value enables the urlLaunch
           String done = 'link';
           return done;
         }
       }
     }
   }

   //handle the <p> closing tag ...
   static pClosingHandler(String xmlString){
     String xmlFrame = xmlString;
     List<String> xmlSplitter = [];
     //check for <p> tag...
     if(xmlFrame.contains('<p>')){
       List<String> xmlSplit = xmlFrame.split('<p');
       xmlSplit.forEach((element) {
        //avoid null cases..
         if(element.isNotEmpty){
           //condition to check indexOf of tag within the string and compare index.
           if(element.indexOf('</div>') > element.indexOf('</p>') && element.indexOf('</p>') == -1 && xmlSplitter.isNotEmpty){
             //replace the first instance of tag
             element.replaceFirst('</div', '</p> </div');
             xmlSplitter.add(element.replaceFirst('</div', '</p> </div'));
           }else{
             xmlSplitter.add(element);
           }
         }
       });
      // join the list strings
       String xmlResults = xmlSplitter.join('<p');
       return xmlResults;
     }
   }

   //extract the attribute value for img and href( <a> )
   static decode(XmlNodeList<XmlAttribute> element,String xmlNode){
    int i;
    //pick the src || href link only to avoid repetition...
       for(i = 0; i< element.length -1;){
         if(element[i].name.toString() == xmlNode){
           //return value of the src || href attribute
           return element[i].value.toString();
         }
         i++;
     }
  }

   //retrieve all text with co-responding xmlTag
   static xmlNodeText(List<String> xmlElement,{required XmlDocument xmlDocument, required List<String> xmlImages,required List<String> xmlA}){
     Map<String, List<String>> singleData = {};
     List<Map<String,List<String>>> xmlData = [];
     // ignore: non_constant_identifier_names
     List<String> Key = [];
     // to extract the specific tag node values
     for (var key in xmlElement){
       if(!Key.contains(key) && key != 'img'){
         List<String> nodeText = [];
         Key.add(key);
         final tag = xmlDocument.findAllElements(key);
         tag.map((node) => node.text).forEach(
                 (element) {
                   nodeText.add(element.toString());
                 });
         singleData.putIfAbsent(key, () =>nodeText);
       }
     }
     singleData.putIfAbsent('img', () => xmlImages);
     singleData.putIfAbsent('A', () => xmlA);
     xmlData.add(singleData);
     return xmlData;
   }

   // retrieve first img src  value for article gridView page
   static firstDecode(String xmlJson){
     String image = '';
     try{
       XmlDocument document;
       //fetch the correct xml document for getting images.
       document = xmlResponse(xmlJson);
       final img = document.findAllElements('img');
      if(image.length == 0) img.map((e) => e.attributes).forEach((element)
       {
         image = decode(element,'src');
       });
        return image;
     }
     catch(e){
       return '';
     }
   }

   //set time difference (grid view) && set time dd/mm/yy in article page
   static timeDuration(String date,bool page){
     var dateStr = date;
     RegExp regExp = RegExp(r"(.*, \d+ .* \d+ \d+:\d+:\d+)");
     if (regExp.hasMatch(dateStr)) {
       var groups = regExp.firstMatch(dateStr);
       var date = HttpDate.parse(groups![1]! + " GMT");
        DateTime.parse(date.toString()).timeago();
        //return String of the duration.
        return page == true ?DateTime.parse(date.toString()).timeago() : '${date.day}/${date.month}/${date.year}';
     }
   }

   //remove the iframe from String
   static iFrameExtractor(String iFrame) {

     String xmlFrame = iFrame;
     //loop to check if youtube video is more than 1.
     while(xmlFrame.contains("<iframe")) {
       //iframeExtractor ...
       const start = "<iframe";
       const end = "></iframe>";
       final startIndex = xmlFrame.indexOf(start);
       final endIndex = xmlFrame.indexOf(end, startIndex + start.length);
       final iFrameContent = xmlFrame.substring(startIndex + start.length, endIndex);
       final cut =  xmlFrame.replaceAll( '<iframe'+iFrameContent+'></iframe>',
           '<p> title="${titleExtractor(xmlFrame.substring(startIndex + start.length, endIndex))}",'
               'src="${srcExtractor(xmlFrame.substring(startIndex + start.length, endIndex))}"</p>');

       xmlFrame = cut;
     }
     return xmlFrame;
   }

   //Get title of youtube video
   static titleExtractor(String iFrame){
     const starts = "title=\"";
     const ends = "\"";
     final startIndexing = iFrame.indexOf(starts);
     final endIndexing = iFrame.indexOf(ends, startIndexing + starts.length);
     // title
     return iFrame.substring(startIndexing + starts.length, endIndexing);
   }

   //Get src for youtube video
   static srcExtractor(String iFrame){
     const starting = "src=\"";
     const ending= "\"";
     final startIndexing = iFrame.indexOf(starting);
     final endIndexing = iFrame.indexOf(ending, startIndexing + starting.length);
     //src
      return iFrame.substring(startIndexing + starting.length, endIndexing);
   }

   //Get id from youtube url
   static idExtractor(String src){
     const start  = "embed/";
     const end = "?feature=oembed";
     final startIndex =  src.indexOf(start);
     final endIndex =  src.indexOf(end,startIndex+ start.length);
     //video id for youtubePlayer
     return src.substring(startIndex + start.length, endIndex);
   }

   //get id for the Vimeo player
   static idVimeoExtractor(String src){
     const start  = "video/";
     const end = "?";
     final startIndex =  src.indexOf(start);
     final endIndex =  src.indexOf(end,startIndex+ start.length);
     //video id for vimeoID
     return src.substring(startIndex + start.length, endIndex);
   }

   //Check in string contain key
   static containChecker(Map<String,String> checker,String hyperText,{bool textBuilder =  false}) {
     bool checkValue = false;
     List<String> checkerList = [];
     List<String> keyList = [];
     Map<String,String> finalResults = {};
     checker.forEach((key, value) {
       checkerList.add(key);
     });
     for(var key in checkerList){
       if(hyperText.contains(key)){
        if(textBuilder== false)keyList.add(key);
        checkValue = true;
       }
     }
     if(textBuilder == false)checker.forEach((key, value) {
       if(keyList.contains(key)){
         finalResults.putIfAbsent(key, () => value);
       }
     });
     // return bool or the urlLink
     return textBuilder == true ? checkValue: finalResults;
   }

   //Separate normal string from urlLaunch string
   static stringInjector(Map<String,String> checker,String hyperText){
     var finalText = hyperText;
     List<String> finalList = [];
     for(var context in checker.keys) {
       if(context.isNotEmpty){
        var parts = finalText.split(context);
        finalList.add(parts[0].trim());
        if (parts.length > 1 && context.isNotEmpty) {
          // ctrlshiftpgdnpguphome::: <----- separator value.
          finalList.add("ctrlshiftpgdnpguphome:::" + context);
          finalText = parts[1].trim();
        }
      }
    }
     finalList.add(finalText);
     return finalList;
     }
}

