/* 
================================================================================
檔案代號:apag_t
檔案名稱:零用金撥補申請主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table apag_t
(
apagent       number(5)      ,/* 集團碼 */
apagsite       varchar2(10)      ,/* 帳務中心 */
apagcomp       varchar2(10)      ,/* 法人組織 */
apagdocno       varchar2(20)      ,/* 撥補單號 */
apagdocdt       date      ,/* 申請日期 */
apag001       varchar2(10)      ,/* 零用金帳戶 */
apag002       varchar2(20)      ,/* 申請人員 */
apag003       varchar2(1)      ,/* 結案否 */
apagud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
apagud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
apagud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
apagud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
apagud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
apagud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
apagud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
apagud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
apagud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
apagud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
apagud011       number(20,6)      ,/* 自定義欄位(數字)011 */
apagud012       number(20,6)      ,/* 自定義欄位(數字)012 */
apagud013       number(20,6)      ,/* 自定義欄位(數字)013 */
apagud014       number(20,6)      ,/* 自定義欄位(數字)014 */
apagud015       number(20,6)      ,/* 自定義欄位(數字)015 */
apagud016       number(20,6)      ,/* 自定義欄位(數字)016 */
apagud017       number(20,6)      ,/* 自定義欄位(數字)017 */
apagud018       number(20,6)      ,/* 自定義欄位(數字)018 */
apagud019       number(20,6)      ,/* 自定義欄位(數字)019 */
apagud020       number(20,6)      ,/* 自定義欄位(數字)020 */
apagud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
apagud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
apagud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
apagud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
apagud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
apagud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
apagud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
apagud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
apagud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
apagud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
apagownid       varchar2(20)      ,/* 資料所有者 */
apagowndp       varchar2(10)      ,/* 資料所屬部門 */
apagcrtid       varchar2(20)      ,/* 資料建立者 */
apagcrtdp       varchar2(10)      ,/* 資料建立部門 */
apagcrtdt       timestamp(0)      ,/* 資料創建日 */
apagmodid       varchar2(20)      ,/* 資料修改者 */
apagmoddt       timestamp(0)      ,/* 最近修改日 */
apagcnfid       varchar2(20)      ,/* 資料確認者 */
apagcnfdt       timestamp(0)      ,/* 資料確認日 */
apagstus       varchar2(10)      /* 狀態碼 */
);
alter table apag_t add constraint apag_pk primary key (apagent,apagcomp,apagdocno) enable validate;

create unique index apag_pk on apag_t (apagent,apagcomp,apagdocno);

grant select on apag_t to tiptop;
grant update on apag_t to tiptop;
grant delete on apag_t to tiptop;
grant insert on apag_t to tiptop;

exit;
