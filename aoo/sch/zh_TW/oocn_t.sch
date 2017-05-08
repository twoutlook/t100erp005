/* 
================================================================================
檔案代號:oocn_t
檔案名稱:郵政編碼檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocn_t
(
oocnent       number(5)      ,/* 企業編號 */
oocnstus       varchar2(10)      ,/* 狀態碼 */
oocn001       varchar2(10)      ,/* 國家地區編號 */
oocn002       varchar2(12)      ,/* 郵政編號 */
oocn003       varchar2(10)      ,/* 州省編號 */
oocn004       varchar2(10)      ,/* 縣市編號 */
oocn005       varchar2(10)      ,/* 行政地區編號 */
oocnownid       varchar2(20)      ,/* 資料所有者 */
oocnowndp       varchar2(10)      ,/* 資料所屬部門 */
oocncrtid       varchar2(20)      ,/* 資料建立者 */
oocncrtdp       varchar2(10)      ,/* 資料建立部門 */
oocncrtdt       timestamp(0)      ,/* 資料創建日 */
oocnmodid       varchar2(20)      ,/* 資料修改者 */
oocnmoddt       timestamp(0)      ,/* 最近修改日 */
oocn006       varchar2(4000)      ,/* 其他地址 */
oocn007       number(10,0)      ,/* 序號 */
oocnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocn_t add constraint oocn_pk primary key (oocnent,oocn001,oocn007) enable validate;

create  index oocn_01 on oocn_t (oocn001);
create unique index oocn_pk on oocn_t (oocnent,oocn001,oocn007);

grant select on oocn_t to tiptop;
grant update on oocn_t to tiptop;
grant delete on oocn_t to tiptop;
grant insert on oocn_t to tiptop;

exit;
