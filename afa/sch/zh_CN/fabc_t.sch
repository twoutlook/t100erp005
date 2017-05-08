/* 
================================================================================
檔案代號:fabc_t
檔案名稱:資產折畢再提單頭主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table fabc_t
(
fabcent       number(5)      ,/* 企業編號 */
fabcld       varchar2(20)      ,/* 帳套 */
fabcdocno       varchar2(20)      ,/* 折畢再提單號 */
fabcdocdt       date      ,/* 單據日期 */
fabcsite       varchar2(10)      ,/* 資金中心 */
fabc001       varchar2(20)      ,/* 帳務人員 */
fabc002       number(10)      ,/* 單據性質 */
fabcstus       varchar2(10)      ,/* 狀態碼 */
fabcownid       varchar2(20)      ,/* 資料所有者 */
fabcowndp       varchar2(10)      ,/* 資料所屬部門 */
fabccrtid       varchar2(20)      ,/* 資料建立者 */
fabccrtdp       varchar2(10)      ,/* 資料建立部門 */
fabccrtdt       timestamp(0)      ,/* 資料創建日 */
fabcmodid       varchar2(20)      ,/* 資料修改者 */
fabcmoddt       timestamp(0)      ,/* 最近修改日 */
fabccnfid       varchar2(20)      ,/* 資料確認者 */
fabccnfdt       timestamp(0)      ,/* 資料確認日 */
fabcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fabcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fabcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fabcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fabcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fabcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fabcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fabcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fabcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fabcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fabcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fabcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fabcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fabcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fabcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fabcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fabcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fabcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fabcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fabcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fabcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fabcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fabcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fabcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fabcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fabcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fabcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fabcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fabcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fabcud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table fabc_t add constraint fabc_pk primary key (fabcent,fabcld,fabcdocno) enable validate;

create unique index fabc_pk on fabc_t (fabcent,fabcld,fabcdocno);

grant select on fabc_t to tiptop;
grant update on fabc_t to tiptop;
grant delete on fabc_t to tiptop;
grant insert on fabc_t to tiptop;

exit;
