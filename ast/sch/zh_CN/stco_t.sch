/* 
================================================================================
檔案代號:stco_t
檔案名稱:分銷客戶合作進場協議產品明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stco_t
(
stcoent       number(5)      ,/* 企業編號 */
stcounit       varchar2(10)      ,/* 應用組織 */
stcosite       varchar2(10)      ,/* 營運據點 */
stcodocno       varchar2(20)      ,/* 單據編號 */
stcoseq       number(10,0)      ,/* 項次 */
stco001       varchar2(40)      ,/* 商品編號 */
stco002       varchar2(80)      ,/* 備註 */
stcoud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcoud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcoud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcoud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcoud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcoud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcoud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcoud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcoud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcoud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcoud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcoud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcoud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcoud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcoud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcoud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcoud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcoud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcoud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcoud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcoud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcoud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcoud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcoud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcoud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcoud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcoud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcoud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcoud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcoud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stco_t add constraint stco_pk primary key (stcoent,stcodocno,stcoseq) enable validate;

create unique index stco_pk on stco_t (stcoent,stcodocno,stcoseq);

grant select on stco_t to tiptop;
grant update on stco_t to tiptop;
grant delete on stco_t to tiptop;
grant insert on stco_t to tiptop;

exit;
