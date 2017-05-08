gwcLocalizedMessages["zh"] = 
gwcLocalizedMessages["zh-CN"] = {
   unexpectedClosingWarningMessage: '此应用程序仍在运行。\n如果你现在离开，一些数据可能丢失。\请在离开这个页面之前退出应用程序。',
	clickForDownload: '如果檔案沒有自動下載，請點擊此連結。',
	fileUploadConfirmation: '上传此档案？',
	monthList: '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月',
	dayList: '周日,周一,周二,周三,周四,周五,周六',
	decimalSeparator: '.',
	'restore column sort':'重置列排序',
	'show all columns':'显示所有列',
	'Stored settings':'存储设置',
	'Disable':'禁用',
	'Read only':'唯读',
	'Clear settings':'清除设置',
	'restore default settings':'重置设置',
	'Stored settings changed':'存储的设置已被更改。请重新启动应用程序使更改生效。',
	'Clear stored settings question':'您想清除存储的设置？（请重新启动应用程序使更改生效。）',
	'freeze left':'向左冻结',
	'freeze right':'向右冻结',
	'unfreeze all':'取消冻结',
	'hide all but selected':'隐藏未选取',
	'network error':'此应用程序已无法運作（错误%1）。請重新整理(F5)页面後重試。'
};
gwcLocalizedMessages["zh-TW"] = {
   unexpectedClosingWarningMessage: '此應用程式仍在運行。\n如果現在離開，一些資料可能遺失。\n請在離開這個頁面之前退出應用程式。',
	clickForDownload: '如果檔案沒有自動下載，請點擊此連結。',
	fileUploadConfirmation: '上傳此檔案？',
	monthList: '一月,二月,三月,四月,五月,六月,七月,八月,九月,十月,十一月,十二月',
	dayList: '週日,週一,週二,週三,週四,週五,週六',
	decimalSeparator: '.',
	'restore column sort':'重設欄位排序',
	'show all columns':'顯示所有欄位',
	'Stored settings':'儲存設置',
	'Disable':'停用',
	'Read only':'唯讀',
	'Clear settings':'清除設置',
	'restore default settings':'重設設置',
	'Stored settings changed':'儲存設置已變更。請重新執行應用程式以套用新的變更。',
	'Clear stored settings question':'您想清除儲存設置？ (請重新執行應用程式以套用新的變更。)',
	'freeze left':'向左凍結',
	'freeze right':'向右凍結',
	'unfreeze all':'取消凍結',
	'hide all but selected':'隱藏未選取',
	'network error':'此應用程式已無法運作 (錯誤 %1)。請重新整理(F5)網頁後重試。'
};
gwc.api.getMessage = function(messageName){
   var defaultLang = 'zh';
   var lang = window.navigator.language || window.navigator.userLanguage;
   var langSet = {};
   if(lang.substr(0,2) == 'zh'){
      langSet = gwcLocalizedMessages[lang] || gwcLocalizedMessages[defaultLang];
   }else{
      lang = lang.substr(0,2);
      langSet = gwcLocalizedMessages[lang] || gwcLocalizedMessages[defaultLang];
   }
   var msg = langSet[messageName] || gwcLocalizedMessages[defaultLang][messageName] || messageName;
   return msg;
};
