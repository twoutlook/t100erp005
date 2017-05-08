/* 
================================================================================
檔案代號:rtdn_t
檔案名稱:商品組成用量單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table rtdn_t
(
rtdnent       number(5)      ,/* 企業編號 */
rtdnunit       varchar2(10)      ,/* 應用組織 */
rtdn001       varchar2(40)      ,/* 主商品編號 */
rtdn002       number(10,0)      ,/* 項次 */
rtdn003       varchar2(40)      ,/* 子商品編號 */
rtdn004       varchar2(40)      ,/* 商品條碼 */
rtdn005       varchar2(10)      ,/* 單位 */
rtdn006       number(20,6)      ,/* 組成用量 */
rtdn007       number(20,6)      ,/* 主件底數 */
rtdn008       number(20,6)      ,/* 變動損耗率 */
rtdn009       number(20,6)      ,/* 固定損耗率 */
rtdn010       number(20,6)      ,/* 成本分攤比例 */
rtdn011       date      ,/* 生效日期時間 */
rtdn012       date      ,/* 失效日期時間 */
rtdnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtdnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtdnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtdnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtdnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtdnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtdnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtdnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtdnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtdnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtdnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtdnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtdnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtdnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtdnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtdnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtdnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtdnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtdnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtdnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtdnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtdnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtdnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtdnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtdnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtdnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtdnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtdnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtdnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtdnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtdn_t add constraint rtdn_pk primary key (rtdnent,rtdn001,rtdn002) enable validate;

create unique index rtdn_pk on rtdn_t (rtdnent,rtdn001,rtdn002);

grant select on rtdn_t to tiptop;
grant update on rtdn_t to tiptop;
grant delete on rtdn_t to tiptop;
grant insert on rtdn_t to tiptop;

exit;
