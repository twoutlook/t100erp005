/* 
================================================================================
檔案代號:oocm_t
檔案名稱:行政地區檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table oocm_t
(
oocmstus       varchar2(10)      ,/* 狀態碼 */
oocment       number(5)      ,/* 企業編號 */
oocm001       varchar2(10)      ,/* 國家地區編號 */
oocm002       varchar2(10)      ,/* 州省編號 */
oocm003       varchar2(10)      ,/* 縣市編號 */
oocm004       varchar2(10)      ,/* 行政地區編號 */
oocmownid       varchar2(20)      ,/* 資料所有者 */
oocmowndp       varchar2(10)      ,/* 資料所屬部門 */
oocmcrtid       varchar2(20)      ,/* 資料建立者 */
oocmcrtdp       varchar2(10)      ,/* 資料建立部門 */
oocmcrtdt       timestamp(0)      ,/* 資料創建日 */
oocmmodid       varchar2(20)      ,/* 資料修改者 */
oocmmoddt       timestamp(0)      ,/* 最近修改日 */
oocmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oocmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oocmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oocmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oocmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oocmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oocmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oocmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oocmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oocmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oocmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oocmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oocmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oocmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oocmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oocmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oocmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oocmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oocmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oocmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oocmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oocmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oocmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oocmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oocmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oocmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oocmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oocmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oocmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oocmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table oocm_t add constraint oocm_pk primary key (oocment,oocm001,oocm002,oocm003,oocm004) enable validate;

create unique index oocm_pk on oocm_t (oocment,oocm001,oocm002,oocm003,oocm004);

grant select on oocm_t to tiptop;
grant update on oocm_t to tiptop;
grant delete on oocm_t to tiptop;
grant insert on oocm_t to tiptop;

exit;
