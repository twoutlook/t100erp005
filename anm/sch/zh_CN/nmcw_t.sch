/* 
================================================================================
檔案代號:nmcw_t
檔案名稱:資金計劃審批明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table nmcw_t
(
nmcwent       number(5)      ,/* 企業編號 */
nmcwdocno       varchar2(20)      ,/* 資金計劃單號 */
nmcw002       varchar2(10)      ,/* 審批單位 */
nmcwseq       number(10,0)      ,/* 序號 */
nmcw001       number(20,6)      ,/* 審批金額 */
nmcwud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcwud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcwud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcwud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcwud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcwud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcwud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcwud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcwud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcwud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcwud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcwud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcwud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcwud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcwud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcwud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcwud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcwud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcwud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcwud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcwud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcwud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcwud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcwud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcwud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcwud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcwud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcwud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcwud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcwud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcw_t add constraint nmcw_pk primary key (nmcwent,nmcwdocno,nmcw002,nmcwseq) enable validate;

create unique index nmcw_pk on nmcw_t (nmcwent,nmcwdocno,nmcw002,nmcwseq);

grant select on nmcw_t to tiptop;
grant update on nmcw_t to tiptop;
grant delete on nmcw_t to tiptop;
grant insert on nmcw_t to tiptop;

exit;
