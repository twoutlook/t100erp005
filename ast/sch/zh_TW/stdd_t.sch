/* 
================================================================================
檔案代號:stdd_t
檔案名稱:內部結算對象配置資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stdd_t
(
stddent       number(5)      ,/* 企業編號 */
stdd001       varchar2(10)      ,/* 結算中心 */
stdd002       number(10,0)      ,/* 項次 */
stdd003       varchar2(10)      ,/* 對象類型 */
stdd004       varchar2(10)      ,/* 結算對象1 */
stdd005       varchar2(10)      ,/* 結算對象2 */
stddud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stddud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stddud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stddud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stddud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stddud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stddud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stddud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stddud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stddud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stddud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stddud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stddud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stddud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stddud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stddud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stddud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stddud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stddud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stddud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stddud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stddud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stddud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stddud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stddud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stddud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stddud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stddud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stddud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stddud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stdd_t add constraint stdd_pk primary key (stddent,stdd001,stdd002) enable validate;

create unique index stdd_pk on stdd_t (stddent,stdd001,stdd002);

grant select on stdd_t to tiptop;
grant update on stdd_t to tiptop;
grant delete on stdd_t to tiptop;
grant insert on stdd_t to tiptop;

exit;
