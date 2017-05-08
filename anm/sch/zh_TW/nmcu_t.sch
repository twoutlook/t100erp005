/* 
================================================================================
檔案代號:nmcu_t
檔案名稱:資金計劃變更日期明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:Y
============.========================.==========================================
 */
create table nmcu_t
(
nmcuent       number(5)      ,/* 企業編號 */
nmcudocno       varchar2(20)      ,/* 資金計劃單號 */
nmcu001       number(10,0)      ,/* 變更版本 */
nmcuseq       number(10,0)      ,/* 序號 */
nmcu002       date      ,/* 計劃日期 */
nmcu003       number(20,6)      ,/* 變更前金額 */
nmcu004       number(20,6)      ,/* 變更後金額 */
nmcuud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmcuud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmcuud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmcuud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmcuud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmcuud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmcuud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmcuud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmcuud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmcuud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmcuud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmcuud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmcuud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmcuud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmcuud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmcuud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmcuud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmcuud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmcuud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmcuud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmcuud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmcuud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmcuud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmcuud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmcuud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmcuud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmcuud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmcuud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmcuud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmcuud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmcu_t add constraint nmcu_pk primary key (nmcuent,nmcudocno,nmcu001,nmcuseq,nmcu002) enable validate;

create unique index nmcu_pk on nmcu_t (nmcuent,nmcudocno,nmcu001,nmcuseq,nmcu002);

grant select on nmcu_t to tiptop;
grant update on nmcu_t to tiptop;
grant delete on nmcu_t to tiptop;
grant insert on nmcu_t to tiptop;

exit;
