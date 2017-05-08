/* 
================================================================================
檔案代號:mmcg_t
檔案名稱:卡折扣一般規則設定單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mmcg_t
(
mmcgent       number(5)      ,/* 企業編號 */
mmcg001       varchar2(30)      ,/* 活動規則編號 */
mmcg002       varchar2(10)      ,/* 卡種編號 */
mmcg003       varchar2(10)      ,/* 規則類型 */
mmcg004       varchar2(40)      ,/* 規則編碼 */
mmcg005       number(20,6)      ,/* 折扣率 */
mmcgstus       varchar2(1)      ,/* 資料有效 */
mmcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmcgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmcg_t add constraint mmcg_pk primary key (mmcgent,mmcg001,mmcg003,mmcg004) enable validate;

create unique index mmcg_pk on mmcg_t (mmcgent,mmcg001,mmcg003,mmcg004);

grant select on mmcg_t to tiptop;
grant update on mmcg_t to tiptop;
grant delete on mmcg_t to tiptop;
grant insert on mmcg_t to tiptop;

exit;
