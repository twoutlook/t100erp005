/* 
================================================================================
檔案代號:mrbi_t
檔案名稱:資源群組設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table mrbi_t
(
mrbient       number(5)      ,/* 企業編號 */
mrbisite       varchar2(10)      ,/* 營運據點 */
mrbi001       varchar2(10)      ,/* 資源群組 */
mrbi002       varchar2(20)      ,/* 資源編號 */
mrbiownid       varchar2(20)      ,/* 資料所有者 */
mrbiowndp       varchar2(10)      ,/* 資料所屬部門 */
mrbicrtid       varchar2(20)      ,/* 資料建立者 */
mrbicrtdp       varchar2(10)      ,/* 資料建立部門 */
mrbicrtdt       timestamp(0)      ,/* 資料創建日 */
mrbimodid       varchar2(20)      ,/* 資料修改者 */
mrbimoddt       timestamp(0)      ,/* 最近修改日 */
mrbistus       varchar2(10)      ,/* 狀態碼 */
mrbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mrbi_t add constraint mrbi_pk primary key (mrbient,mrbisite,mrbi001,mrbi002) enable validate;

create unique index mrbi_pk on mrbi_t (mrbient,mrbisite,mrbi001,mrbi002);

grant select on mrbi_t to tiptop;
grant update on mrbi_t to tiptop;
grant delete on mrbi_t to tiptop;
grant insert on mrbi_t to tiptop;

exit;
