/* 
================================================================================
檔案代號:dbea_t
檔案名稱:配送預排單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:Y
============.========================.==========================================
 */
create table dbea_t
(
dbeaent       number(5)      ,/* 企業編號 */
dbeasite       varchar2(10)      ,/* 營運據點 */
dbeaunit       varchar2(10)      ,/* 應用組織 */
dbeadocno       varchar2(20)      ,/* 單據編號 */
dbeadocdt       date      ,/* 單據日期 */
dbea001       date      ,/* 出貨日期 */
dbea002       varchar2(20)      ,/* 預排人員 */
dbea003       varchar2(10)      ,/* 預排部門 */
dbeastus       varchar2(10)      ,/* 狀態 */
dbeaownid       varchar2(20)      ,/* 資料所有者 */
dbeaowndp       varchar2(10)      ,/* 資料所屬部門 */
dbeacrtid       varchar2(20)      ,/* 資料建立者 */
dbeacrtdp       varchar2(10)      ,/* 資料建立部門 */
dbeacrtdt       timestamp(0)      ,/* 資料創建日 */
dbeamodid       varchar2(20)      ,/* 資料修改者 */
dbeamoddt       timestamp(0)      ,/* 最近修改日 */
dbeacnfid       varchar2(20)      ,/* 資料確認者 */
dbeacnfdt       timestamp(0)      ,/* 資料確認日 */
dbeaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbeaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbeaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbeaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbeaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbeaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbeaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbeaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbeaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbeaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbeaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbeaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbeaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbeaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbeaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbeaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbeaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbeaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbeaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbeaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbeaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbeaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbeaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbeaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbeaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbeaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbeaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbeaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbeaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbeaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbea_t add constraint dbea_pk primary key (dbeaent,dbeadocno) enable validate;

create unique index dbea_pk on dbea_t (dbeaent,dbeadocno);

grant select on dbea_t to tiptop;
grant update on dbea_t to tiptop;
grant delete on dbea_t to tiptop;
grant insert on dbea_t to tiptop;

exit;
