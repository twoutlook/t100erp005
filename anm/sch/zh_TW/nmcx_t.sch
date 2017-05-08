/* 
================================================================================
檔案代號:nmcx_t
檔案名稱:資金計劃審批日期明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table nmcx_t
(
nmcxent       number(5)      ,/* 企業編號 */
nmcxdocno       varchar2(20)      ,/* 資金計劃單號 */
nmcx003       varchar2(10)      ,/* 審批單位 */
nmcxseq       number(10,0)      ,/* 序號 */
nmcx001       date      ,/* 計劃日期 */
nmcx002       number(20,6)      ,/* 審批金額 */
nmcxud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcxud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcxud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcxud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcxud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcxud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcxud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcxud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcxud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcxud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcxud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcxud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcxud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcxud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcxud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcxud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcxud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcxud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcxud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcxud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcxud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcxud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcxud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcxud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcxud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcxud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcxud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcxud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcxud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcxud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcx_t add constraint nmcx_pk primary key (nmcxent,nmcxdocno,nmcx003,nmcxseq,nmcx001) enable validate;

create unique index nmcx_pk on nmcx_t (nmcxent,nmcxdocno,nmcx003,nmcxseq,nmcx001);

grant select on nmcx_t to tiptop;
grant update on nmcx_t to tiptop;
grant delete on nmcx_t to tiptop;
grant insert on nmcx_t to tiptop;

exit;
