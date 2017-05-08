/* 
================================================================================
檔案代號:nmct_t
檔案名稱:資金計劃變更明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table nmct_t
(
nmctent       number(5)      ,/* 企業編號 */
nmctdocno       varchar2(20)      ,/* 資金計劃單號 */
nmct001       number(10,0)      ,/* 變更版本 */
nmctseq       number(10,0)      ,/* 序號 */
nmct002       number(20,6)      ,/* 變更前金額 */
nmct003       number(20,6)      ,/* 變更後金額 */
nmctud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmctud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmctud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmctud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmctud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmctud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmctud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmctud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmctud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmctud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmctud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmctud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmctud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmctud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmctud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmctud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmctud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmctud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmctud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmctud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmctud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmctud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmctud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmctud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmctud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmctud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmctud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmctud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmctud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmctud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmct_t add constraint nmct_pk primary key (nmctent,nmctdocno,nmct001,nmctseq) enable validate;

create unique index nmct_pk on nmct_t (nmctent,nmctdocno,nmct001,nmctseq);

grant select on nmct_t to tiptop;
grant update on nmct_t to tiptop;
grant delete on nmct_t to tiptop;
grant insert on nmct_t to tiptop;

exit;
