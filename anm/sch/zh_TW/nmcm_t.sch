/* 
================================================================================
檔案代號:nmcm_t
檔案名稱:扣款項目明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table nmcm_t
(
nmcment       number(5)      ,/* 企業編碼 */
nmcmcomp       varchar2(10)      ,/* 法人 */
nmcmdocno       varchar2(20)      ,/* 單據號碼 */
nmcmseq       number(10,0)      ,/* 序號 */
nmcm001       varchar2(10)      ,/* 理由碼 */
nmcm002       number(20,6)      ,/* 原幣 */
nmcm003       number(20,6)      ,/* 本幣 */
nmcm004       varchar2(24)      ,/* 會科代碼 */
nmcm005       varchar2(10)      ,/* 現金變動碼 */
nmcmud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcmud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcmud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcmud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcmud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcmud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcmud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcmud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcmud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcmud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcmud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcmud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcmud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcmud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcmud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcmud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcmud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcmud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcmud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcmud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcmud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcmud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcmud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcmud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcmud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcmud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcmud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcmud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcmud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcmud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcm_t add constraint nmcm_pk primary key (nmcment,nmcmcomp,nmcmdocno,nmcmseq) enable validate;

create unique index nmcm_pk on nmcm_t (nmcment,nmcmcomp,nmcmdocno,nmcmseq);

grant select on nmcm_t to tiptop;
grant update on nmcm_t to tiptop;
grant delete on nmcm_t to tiptop;
grant insert on nmcm_t to tiptop;

exit;
