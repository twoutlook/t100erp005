/* 
================================================================================
檔案代號:dbee_t
檔案名稱:配送排車單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table dbee_t
(
dbeeent       number(5)      ,/* 企業編號 */
dbeesite       varchar2(10)      ,/* 營運據點 */
dbeeunit       varchar2(10)      ,/* 應用組織 */
dbeedocno       varchar2(20)      ,/* 單據編號 */
dbeedocdt       date      ,/* 單據日期 */
dbee001       date      ,/* 出貨日期 */
dbee002       varchar2(20)      ,/* 車輛編號 */
dbee003       varchar2(40)      ,/* 車次 */
dbee004       varchar2(10)      ,/* 路線編號 */
dbee005       varchar2(10)      ,/* 裝載點 */
dbee006       number(20,6)      ,/* 承載容積 */
dbee007       varchar2(10)      ,/* 承載容積單位 */
dbee008       number(20,6)      ,/* 承載重量 */
dbee009       varchar2(10)      ,/* 承載重量單位 */
dbee010       varchar2(20)      ,/* 排車人員 */
dbee011       varchar2(10)      ,/* 排車部門 */
dbee012       number(20,6)      ,/* 已排容積 */
dbee013       number(20,6)      ,/* 已排重量 */
dbeestus       varchar2(10)      ,/* 狀態 */
dbeeownid       varchar2(20)      ,/* 資料所有者 */
dbeeowndp       varchar2(10)      ,/* 資料所屬部門 */
dbeecrtid       varchar2(20)      ,/* 資料建立者 */
dbeecrtdp       varchar2(10)      ,/* 資料建立部門 */
dbeecrtdt       timestamp(0)      ,/* 資料創建日 */
dbeemodid       varchar2(20)      ,/* 資料修改者 */
dbeemoddt       timestamp(0)      ,/* 最近修改日 */
dbeecnfid       varchar2(20)      ,/* 資料確認者 */
dbeecnfdt       timestamp(0)      ,/* 資料確認日 */
dbeeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbeeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbeeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbeeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbeeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbeeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbeeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbeeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbeeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbeeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbeeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbeeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbeeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbeeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbeeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbeeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbeeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbeeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbeeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbeeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbeeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbeeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbeeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbeeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbeeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbeeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbeeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbeeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbeeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbeeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbee_t add constraint dbee_pk primary key (dbeeent,dbeedocno) enable validate;

create unique index dbee_pk on dbee_t (dbeeent,dbeedocno);

grant select on dbee_t to tiptop;
grant update on dbee_t to tiptop;
grant delete on dbee_t to tiptop;
grant insert on dbee_t to tiptop;

exit;
