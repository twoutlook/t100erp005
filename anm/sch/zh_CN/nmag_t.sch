/* 
================================================================================
檔案代號:nmag_t
檔案名稱:銀行帳戶類型設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmag_t
(
nmagent       number(5)      ,/* 企業編號 */
nmagstus       varchar2(10)      ,/* 狀態碼 */
nmag001       varchar2(10)      ,/* 帳戶類型編碼 */
nmagownid       varchar2(20)      ,/* 資料所有者 */
nmagowndp       varchar2(10)      ,/* 資料所屬部門 */
nmagcrtid       varchar2(20)      ,/* 資料建立者 */
nmagcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmagcrtdt       timestamp(0)      ,/* 資料創建日 */
nmagmodid       varchar2(20)      ,/* 資料修改者 */
nmagmoddt       timestamp(0)      ,/* 最近修改日 */
nmag002       varchar2(10)      ,/* 帳戶運用類型 */
nmag003       number(5,0)      ,/* 帳戶數限制 */
nmagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmagud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmag_t add constraint nmag_pk primary key (nmagent,nmag001) enable validate;

create unique index nmag_pk on nmag_t (nmagent,nmag001);

grant select on nmag_t to tiptop;
grant update on nmag_t to tiptop;
grant delete on nmag_t to tiptop;
grant insert on nmag_t to tiptop;

exit;
