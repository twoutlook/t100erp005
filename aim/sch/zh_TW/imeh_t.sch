/* 
================================================================================
檔案代號:imeh_t
檔案名稱:規則化規格可選項檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table imeh_t
(
imehent       number(5)      ,/* 企業編號 */
imeh001       varchar2(10)      ,/* 品名種類 */
imeh002       varchar2(10)      ,/* 節點編號 */
imeh003       varchar2(40)      ,/* 選項值 */
imehud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imehud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imehud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imehud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imehud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imehud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imehud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imehud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imehud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imehud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imehud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imehud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imehud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imehud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imehud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imehud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imehud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imehud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imehud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imehud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imehud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imehud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imehud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imehud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imehud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imehud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imehud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imehud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imehud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imehud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imeh_t add constraint imeh_pk primary key (imehent,imeh001,imeh002,imeh003) enable validate;

create unique index imeh_pk on imeh_t (imehent,imeh001,imeh002,imeh003);

grant select on imeh_t to tiptop;
grant update on imeh_t to tiptop;
grant delete on imeh_t to tiptop;
grant insert on imeh_t to tiptop;

exit;
