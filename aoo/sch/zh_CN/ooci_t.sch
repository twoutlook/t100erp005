/* 
================================================================================
檔案代號:ooci_t
檔案名稱:州省檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooci_t
(
oocistus       varchar2(10)      ,/* 狀態碼 */
oocient       number(5)      ,/* 企業編號 */
ooci001       varchar2(10)      ,/* 所在國家 */
ooci002       varchar2(10)      ,/* 州省編號 */
oociownid       varchar2(20)      ,/* 資料所有者 */
oociowndp       varchar2(10)      ,/* 資料所屬部門 */
oocicrtid       varchar2(20)      ,/* 資料建立者 */
oocicrtdp       varchar2(10)      ,/* 資料建立部門 */
oocicrtdt       timestamp(0)      ,/* 資料創建日 */
oocimodid       varchar2(20)      ,/* 資料修改者 */
oocimoddt       timestamp(0)      ,/* 最近修改日 */
oociud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oociud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oociud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oociud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oociud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oociud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oociud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oociud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oociud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oociud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oociud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oociud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oociud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oociud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oociud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oociud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oociud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oociud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oociud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oociud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oociud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oociud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oociud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oociud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oociud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oociud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oociud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oociud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oociud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oociud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooci_t add constraint ooci_pk primary key (oocient,ooci001,ooci002) enable validate;

create  index ooci_01 on ooci_t (ooci002);
create unique index ooci_pk on ooci_t (oocient,ooci001,ooci002);

grant select on ooci_t to tiptop;
grant update on ooci_t to tiptop;
grant delete on ooci_t to tiptop;
grant insert on ooci_t to tiptop;

exit;
