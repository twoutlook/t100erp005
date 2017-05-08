/* 
================================================================================
檔案代號:isaq_t
檔案名稱:營運據點可用發票類型設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isaq_t
(
isaqent       number(5)      ,/* 企業編號 */
isaqsite       varchar2(10)      ,/* 營運據點 */
isaq001       varchar2(10)      ,/* 發票類型 */
isaq002       varchar2(1)      ,/* 發票購入方式 */
isaq003       varchar2(1)      ,/* 發票回收否 */
isaq004       varchar2(10)      ,/* 套表樣版 */
isaq005       varchar2(1)      ,/* 發票取得時機點 */
isaqstus       varchar2(1)      ,/* 狀態碼 */
isaqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isaqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isaqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isaqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isaqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isaqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isaqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isaqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isaqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isaqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isaqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isaqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isaqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isaqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isaqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isaqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isaqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isaqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isaqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isaqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isaqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isaqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isaqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isaqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isaqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isaqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isaqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isaqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isaqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isaqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isaq_t add constraint isaq_pk primary key (isaqent,isaqsite,isaq001) enable validate;

create unique index isaq_pk on isaq_t (isaqent,isaqsite,isaq001);

grant select on isaq_t to tiptop;
grant update on isaq_t to tiptop;
grant delete on isaq_t to tiptop;
grant insert on isaq_t to tiptop;

exit;
