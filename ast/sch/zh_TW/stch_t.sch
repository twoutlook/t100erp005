/* 
================================================================================
檔案代號:stch_t
檔案名稱:分銷合約經營範圍設定主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stch_t
(
stchent       number(5)      ,/* 企業編號 */
stchsite       varchar2(10)      ,/* 營運據點 */
stchunit       varchar2(10)      ,/* 應用組織 */
stchseq       number(10,0)      ,/* 項次 */
stch001       varchar2(20)      ,/* 合約編號 */
stch002       varchar2(10)      ,/* 品類/品牌編號 */
stch003       varchar2(1)      ,/* 可退貨否 */
stchud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stchud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stchud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stchud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stchud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stchud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stchud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stchud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stchud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stchud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stchud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stchud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stchud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stchud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stchud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stchud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stchud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stchud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stchud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stchud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stchud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stchud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stchud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stchud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stchud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stchud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stchud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stchud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stchud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stchud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stch_t add constraint stch_pk primary key (stchent,stchseq,stch001) enable validate;

create unique index stch_pk on stch_t (stchent,stchseq,stch001);

grant select on stch_t to tiptop;
grant update on stch_t to tiptop;
grant delete on stch_t to tiptop;
grant insert on stch_t to tiptop;

exit;
