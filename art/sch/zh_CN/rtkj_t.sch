/* 
================================================================================
檔案代號:rtkj_t
檔案名稱:自動補貨補貨模型品類週驅勢參數明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtkj_t
(
rtkjent       number(5)      ,/* 企業編號 */
rtkjunit       varchar2(10)      ,/* 應用組織 */
rtkj001       varchar2(10)      ,/* 補貨模型編號 */
rtkj002       varchar2(10)      ,/* 品類編號 */
rtkj101       number(15,3)      ,/* 第1週週趨勢參數 */
rtkj102       number(15,3)      ,/* 第2週週趨勢參數 */
rtkj103       number(15,3)      ,/* 第3週週趨勢參數 */
rtkj104       number(15,3)      ,/* 第4週週趨勢參數 */
rtkj105       number(15,3)      ,/* 第5週週趨勢參數 */
rtkj106       number(15,3)      ,/* 第6週週趨勢參數 */
rtkj107       number(15,3)      ,/* 第7週週趨勢參數 */
rtkj108       number(15,3)      ,/* 第8週週趨勢參數 */
rtkj109       number(15,3)      ,/* 第9週週趨勢參數 */
rtkj110       number(15,3)      ,/* 第10週週趨勢參數 */
rtkj111       number(15,3)      ,/* 第11週週趨勢參數 */
rtkj112       number(15,3)      ,/* 第12週週趨勢參數 */
rtkj113       number(15,3)      ,/* 第13週週趨勢參數 */
rtkj114       number(15,3)      ,/* 第14週週趨勢參數 */
rtkj115       number(15,3)      ,/* 第15週週趨勢參數 */
rtkj116       number(15,3)      ,/* 第16週週趨勢參數 */
rtkj117       number(15,3)      ,/* 第17週週趨勢參數 */
rtkj118       number(15,3)      ,/* 第18週週趨勢參數 */
rtkj119       number(15,3)      ,/* 第19週週趨勢參數 */
rtkj120       number(15,3)      ,/* 第20週週趨勢參數 */
rtkj121       number(15,3)      ,/* 第21週週趨勢參數 */
rtkj122       number(15,3)      ,/* 第22週週趨勢參數 */
rtkj123       number(15,3)      ,/* 第23週週趨勢參數 */
rtkj124       number(15,3)      ,/* 第24週週趨勢參數 */
rtkj125       number(15,3)      ,/* 第25週週趨勢參數 */
rtkj126       number(15,3)      ,/* 第26週週趨勢參數 */
rtkj127       number(15,3)      ,/* 第27週週趨勢參數 */
rtkj128       number(15,3)      ,/* 第28週週趨勢參數 */
rtkj129       number(15,3)      ,/* 第29週週趨勢參數 */
rtkj130       number(15,3)      ,/* 第30週週趨勢參數 */
rtkj131       number(15,3)      ,/* 第31週週趨勢參數 */
rtkj132       number(15,3)      ,/* 第32週週趨勢參數 */
rtkj133       number(15,3)      ,/* 第33週週趨勢參數 */
rtkj134       number(15,3)      ,/* 第34週週趨勢參數 */
rtkj135       number(15,3)      ,/* 第35週週趨勢參數 */
rtkj136       number(15,3)      ,/* 第36週週趨勢參數 */
rtkj137       number(15,3)      ,/* 第37週週趨勢參數 */
rtkj138       number(15,3)      ,/* 第38週週趨勢參數 */
rtkj139       number(15,3)      ,/* 第39週週趨勢參數 */
rtkj140       number(15,3)      ,/* 第40週週趨勢參數 */
rtkj141       number(15,3)      ,/* 第41週週趨勢參數 */
rtkj142       number(15,3)      ,/* 第42週週趨勢參數 */
rtkj143       number(15,3)      ,/* 第43週週趨勢參數 */
rtkj144       number(15,3)      ,/* 第44週週趨勢參數 */
rtkj145       number(15,3)      ,/* 第45週週趨勢參數 */
rtkj146       number(15,3)      ,/* 第46週週趨勢參數 */
rtkj147       number(15,3)      ,/* 第47週週趨勢參數 */
rtkj148       number(15,3)      ,/* 第48週週趨勢參數 */
rtkj149       number(15,3)      ,/* 第49週週趨勢參數 */
rtkj150       number(15,3)      ,/* 第50週週趨勢參數 */
rtkj151       number(15,3)      ,/* 第51週週趨勢參數 */
rtkj152       number(15,3)      ,/* 第52週週趨勢參數 */
rtkjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtkjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtkjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtkjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtkjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtkjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtkjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtkjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtkjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtkjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtkjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtkjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtkjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtkjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtkjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtkjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtkjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtkjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtkjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtkjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtkjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtkjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtkjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtkjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtkjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtkjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtkjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtkjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtkjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtkjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtkj_t add constraint rtkj_pk primary key (rtkjent,rtkj001,rtkj002) enable validate;

create unique index rtkj_pk on rtkj_t (rtkjent,rtkj001,rtkj002);

grant select on rtkj_t to tiptop;
grant update on rtkj_t to tiptop;
grant delete on rtkj_t to tiptop;
grant insert on rtkj_t to tiptop;

exit;
