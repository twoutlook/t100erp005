/* 
================================================================================
檔案代號:isce_t
檔案名稱:兼營營業人營業稅額調整計算表明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isce_t
(
isceent       number(5)      ,/* 企業編碼 */
iscecomp       varchar2(10)      ,/* 法人 */
iscesite       varchar2(10)      ,/* 申報單位 */
isce001       number(5,0)      ,/* 年度 */
isce002       number(5,0)      ,/* 月份 */
isce003       number(20,6)      ,/* 應稅銷售額(1) */
isce004       number(20,6)      ,/* 零稅銷售額(3) */
isce005       number(20,6)      ,/* 免稅銷售額(不含土地)(4)-(8) */
isce006       number(20,6)      ,/* 特種稅額銷售額(5) */
isce007       number(20,6)      ,/* 應比例計算得扣抵進項稅額(9)+(10) */
isce008       number(20,6)      ,/* 得扣抵之進項稅額所以(12) */
isce009       number(20,6)      ,/* 購買國外勞務應比例計算之進項稅額(14) */
isce010       number(20,6)      ,/* 購買國外勞務之應納稅額(15) */
isceud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isceud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isceud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isceud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isceud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isceud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isceud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isceud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isceud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isceud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isceud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isceud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isceud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isceud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isceud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isceud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isceud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isceud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isceud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isceud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isceud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isceud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isceud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isceud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isceud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isceud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isceud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isceud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isceud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isceud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isce_t add constraint isce_pk primary key (isceent,iscecomp,iscesite,isce001,isce002) enable validate;

create unique index isce_pk on isce_t (isceent,iscecomp,iscesite,isce001,isce002);

grant select on isce_t to tiptop;
grant update on isce_t to tiptop;
grant delete on isce_t to tiptop;
grant insert on isce_t to tiptop;

exit;
