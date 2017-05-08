/* 
================================================================================
檔案代號:nmcd_t
檔案名稱:支票明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmcd_t
(
nmcdent       number(5)      ,/* 企業編號 */
nmcdcomp       varchar2(10)      ,/* 法人 */
nmcd001       varchar2(10)      ,/* 交易帳戶編碼 */
nmcd002       varchar2(10)      ,/* 簿號 */
nmcd003       varchar2(20)      ,/* 支票號碼 */
nmcd004       varchar2(10)      ,/* 作廢理由碼 */
nmcd005       varchar2(20)      ,/* 作廢人員 */
nmcd006       varchar2(1)      ,/* 審核否 */
nmcd007       varchar2(20)      ,/* 審核人員 */
nmcd008       varchar2(1)      ,/* 作廢否 */
nmcd009       varchar2(1)      ,/* 支票列印否 */
nmcd010       date      ,/* 審核日期 */
nmcdownid       varchar2(20)      ,/* 資料所有者 */
nmcdowndp       varchar2(10)      ,/* 資料所屬部門 */
nmcdcrtid       varchar2(20)      ,/* 資料建立者 */
nmcdcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmcdcrtdt       timestamp(0)      ,/* 資料創建日 */
nmcdmodid       varchar2(20)      ,/* 資料修改者 */
nmcdmoddt       timestamp(0)      ,/* 最近修改日 */
nmcdstus       varchar2(10)      ,/* 狀態碼 */
nmcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcd_t add constraint nmcd_pk primary key (nmcdent,nmcd002,nmcd003) enable validate;

create unique index nmcd_pk on nmcd_t (nmcdent,nmcd002,nmcd003);

grant select on nmcd_t to tiptop;
grant update on nmcd_t to tiptop;
grant delete on nmcd_t to tiptop;
grant insert on nmcd_t to tiptop;

exit;
