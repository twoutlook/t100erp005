/* 
================================================================================
檔案代號:xcbi_t
檔案名稱:在制報工和統計單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table xcbi_t
(
xcbient       number(5)      ,/* 企業編號 */
xcbisite       varchar2(10)      ,/* 營運據點 */
xcbicomp       varchar2(10)      ,/* 法人組織 */
xcbidocno       varchar2(20)      ,/* 單據編號 */
xcbiseq       number(10,0)      ,/* 行序 */
xcbi001       varchar2(10)      ,/* 成本中心 */
xcbi002       varchar2(20)      ,/* 工單編號 */
xcbi009       varchar2(80)      ,/* 備註 */
xcbi100       number(20,6)      ,/* 入庫數量 */
xcbi101       number(20,6)      ,/* 期末在制數量 */
xcbi102       number(20,6)      ,/* 期末在制約當率 */
xcbi103       number(20,6)      ,/* 期末在制約當量 */
xcbi104       number(20,6)      ,/* 報工數量 */
xcbi201       number(15,3)      ,/* 實際工時 */
xcbi202       number(15,3)      ,/* 實際幾時 */
xcbi203       number(15,3)      ,/* 標準工時 */
xcbi204       number(15,3)      ,/* 標準幾時 */
xcbiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbi_t add constraint xcbi_pk primary key (xcbient,xcbidocno,xcbiseq) enable validate;

create unique index xcbi_pk on xcbi_t (xcbient,xcbidocno,xcbiseq);

grant select on xcbi_t to tiptop;
grant update on xcbi_t to tiptop;
grant delete on xcbi_t to tiptop;
grant insert on xcbi_t to tiptop;

exit;
