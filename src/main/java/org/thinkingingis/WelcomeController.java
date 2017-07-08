package org.thinkingingis;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class WelcomeController {
	
	@Value("${welcome.message:test}")
	private String message = "Hello ThinkingInGIS";
	
	@RequestMapping("/")
	public String welcome(Map<String, Object> model){
		model.put("message", this.message);
		return "welcome";
	}
	
	@RequestMapping(value = "getMapData.do", produces="text/html; charset=UTF-8")
	public @ResponseBody String getMapDataForEcharts(){
		Map<String, Integer> map = new HashMap<String, Integer>();
		
		//在controller中进行数据的组织
		
		Random rand = new Random();
		
		map.put("漷县镇", rand.nextInt(2000));
		map.put("永乐店镇", rand.nextInt(2000));
		map.put("于家务回族乡", rand.nextInt(2000));
		map.put("梨园地区", rand.nextInt(2000));
		map.put("潞城镇", rand.nextInt(2000));
		map.put("马驹桥镇", rand.nextInt(2000));
		map.put("宋庄镇", rand.nextInt(2000));
		map.put("台湖镇", rand.nextInt(2000));
		map.put("西集镇", rand.nextInt(2000));
		map.put("永顺地区", rand.nextInt(2000));
		map.put("张家湾镇", rand.nextInt(2000));
		
		JSONArray data = new JSONArray();
		
		for(String name : map.keySet()){
			JSONObject jo = new JSONObject();
			jo.put("name", name); //name 应与shp转geojson时的name字段对应
			jo.put("value", map.get(name)); //value表示各个镇的值
			data.add(jo);
		}
		
		JSONObject res = new JSONObject(); //定义一个json对象
		res.put("data", data); //data属性
		res.put("maxRange", 2000); //maxrange属性，最大值
		
		System.out.println(res);
		
		return res.toString();
	}

}
