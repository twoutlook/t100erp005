/* 
================================================================================
檔案代號:ooge_t
檔案名稱:製造組別檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooge_t
(
oogeent       number(5)      ,/* 企業編號 */
oogestus       varchar2(10)      ,/* 狀態碼 */
ooge001       varchar2(10)      ,/* 組別編號 */
ooge002       varchar2(80)      ,/* 組別說明 */
oogesite       varchar2(10)      ,/* 營運據點 */
oogeownid       varchar2(20)      ,/* 資料所有者 */
oogeowndp       varchar2(10)      ,/* 資料所屬部門 */
oogecrtid       varchar2(20)      ,/* 資料建立者 */
oogecrtdp       varchar2(10)      ,/* 資料建立部門 */
oogecrtdt       timestamp(0)      ,/* 資料創建日 */
oogemodid       varchar2(20)      ,/* 資料修改者 */
oogemoddt       timestamp(0)      ,/* 最近修改日 */
oogeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
oogeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
oogeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
oogeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
oogeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
oogeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
oogeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
oogeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
oogeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
oogeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
oogeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
oogeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
oogeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
oogeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
oogeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
oogeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
oogeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
oogeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
oogeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
oogeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
oogeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
oogeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
oogeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
oogeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
oogeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
oogeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
oogeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
oogeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
oogeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
oogeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooge_t add constraint ooge_pk primary key (oogeent,ooge001,oogesite) enable validate;

create unique index ooge_pk on ooge_t (oogeent,ooge001,oogesite);

grant select on ooge_t to tiptop;
grant update on ooge_t to tiptop;
grant delete on ooge_t to tiptop;
grant insert on ooge_t to tiptop;

exit;
