/* 
================================================================================
檔案代號:inpj_t
檔案名稱:週期盤點計劃單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inpj_t
(
inpjent       number(5)      ,/* 企業編號 */
inpjsite       varchar2(10)      ,/* 營運據點 */
inpjdocno       varchar2(20)      ,/* 計劃單號 */
inpjdocdt       date      ,/* 輸入日期 */
inpj001       varchar2(1)      ,/* 假日處理方式 */
inpj002       varchar2(20)      ,/* 計劃人員 */
inpj003       varchar2(10)      ,/* 計劃部門 */
inpj004       date      ,/* 計畫盤點日 */
inpj005       varchar2(1)      ,/* 自動產生下一期計畫 */
inpj006       varchar2(255)      ,/* 備註 */
inpj008       varchar2(1)      ,/* A類料件 */
inpj009       varchar2(1)      ,/* B類料件 */
inpj010       varchar2(1)      ,/* C類料件 */
inpj011       varchar2(1)      ,/* 包含已無庫存量 */
inpj012       varchar2(5)      ,/* 盤點單別 */
inpj014       varchar2(1)      ,/* 是否複盤 */
inpj015       varchar2(1)      ,/* 顯示帳上庫存數 */
inpj016       varchar2(1)      ,/* 存貨排序一 */
inpj017       varchar2(1)      ,/* 存貨排序二 */
inpj018       varchar2(1)      ,/* 存貨排序三 */
inpj019       varchar2(1)      ,/* 存貨排序四 */
inpj020       varchar2(1)      ,/* 存貨排序五 */
inpj021       varchar2(1)      ,/* 存貨排序六 */
inpj022       varchar2(1)      ,/* 分群碼選項 */
inpj024       varchar2(1)      ,/* 一月 */
inpj025       varchar2(1)      ,/* 二月 */
inpj026       varchar2(1)      ,/* 三月 */
inpj027       varchar2(1)      ,/* 四月 */
inpj028       varchar2(1)      ,/* 五月 */
inpj029       varchar2(1)      ,/* 六月 */
inpj030       varchar2(1)      ,/* 七月 */
inpj031       varchar2(1)      ,/* 八月 */
inpj032       varchar2(1)      ,/* 九月 */
inpj033       varchar2(1)      ,/* 十月 */
inpj034       varchar2(1)      ,/* 十一月 */
inpj035       varchar2(1)      ,/* 十二月 */
inpj036       varchar2(1)      ,/* 第一週 */
inpj037       varchar2(1)      ,/* 第二週 */
inpj038       varchar2(1)      ,/* 第三週 */
inpj039       varchar2(1)      ,/* 第四週 */
inpj040       varchar2(1)      ,/* 第五週 */
inpj041       varchar2(1)      ,/* 星期一 */
inpj042       varchar2(1)      ,/* 星期二 */
inpj043       varchar2(1)      ,/* 星期三 */
inpj044       varchar2(1)      ,/* 星期四 */
inpj045       varchar2(1)      ,/* 星期五 */
inpj046       varchar2(1)      ,/* 星期六 */
inpj047       varchar2(1)      ,/* 星期日 */
inpj048       varchar2(1)      ,/* 1 */
inpj049       varchar2(1)      ,/* 2 */
inpj050       varchar2(1)      ,/* 3 */
inpj051       varchar2(1)      ,/* 4 */
inpj052       varchar2(1)      ,/* 5 */
inpj053       varchar2(1)      ,/* 6 */
inpj054       varchar2(1)      ,/* 7 */
inpj055       varchar2(1)      ,/* 8 */
inpj056       varchar2(1)      ,/* 9 */
inpj057       varchar2(1)      ,/* 10 */
inpj058       varchar2(1)      ,/* 11 */
inpj059       varchar2(1)      ,/* 12 */
inpj060       varchar2(1)      ,/* 13 */
inpj061       varchar2(1)      ,/* 14 */
inpj062       varchar2(1)      ,/* 15 */
inpj063       varchar2(1)      ,/* 16 */
inpj064       varchar2(1)      ,/* 17 */
inpj065       varchar2(1)      ,/* 18 */
inpj066       varchar2(1)      ,/* 19 */
inpj067       varchar2(1)      ,/* 20 */
inpj068       varchar2(1)      ,/* 21 */
inpj069       varchar2(1)      ,/* 22 */
inpj070       varchar2(1)      ,/* 23 */
inpj071       varchar2(1)      ,/* 24 */
inpj072       varchar2(1)      ,/* 25 */
inpj073       varchar2(1)      ,/* 26 */
inpj074       varchar2(1)      ,/* 27 */
inpj075       varchar2(1)      ,/* 28 */
inpj076       varchar2(1)      ,/* 29 */
inpj077       varchar2(1)      ,/* 30 */
inpj078       varchar2(1)      ,/* 31 */
inpjownid       varchar2(20)      ,/* 資料所有者 */
inpjowndp       varchar2(10)      ,/* 資料所屬部門 */
inpjcrtid       varchar2(20)      ,/* 資料建立者 */
inpjcrtdp       varchar2(10)      ,/* 資料建立部門 */
inpjcrtdt       timestamp(0)      ,/* 資料創建日 */
inpjmodid       varchar2(20)      ,/* 資料修改者 */
inpjmoddt       timestamp(0)      ,/* 最近修改日 */
inpjcnfid       varchar2(20)      ,/* 資料確認者 */
inpjcnfdt       timestamp(0)      ,/* 資料確認日 */
inpjpstid       varchar2(20)      ,/* 資料過帳者 */
inpjpstdt       timestamp(0)      ,/* 資料過帳日 */
inpjstus       varchar2(10)      ,/* 狀態碼 */
inpjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inpjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inpjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inpjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inpjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inpjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inpjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inpjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inpjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inpjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inpjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inpjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inpjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inpjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inpjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inpjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inpjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inpjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inpjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inpjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inpjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inpjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inpjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inpjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inpjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inpjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inpjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inpjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inpjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inpjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inpj_t add constraint inpj_pk primary key (inpjent,inpjsite,inpjdocno) enable validate;

create unique index inpj_pk on inpj_t (inpjent,inpjsite,inpjdocno);

grant select on inpj_t to tiptop;
grant update on inpj_t to tiptop;
grant delete on inpj_t to tiptop;
grant insert on inpj_t to tiptop;

exit;
