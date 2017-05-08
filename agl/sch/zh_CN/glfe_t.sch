/* 
================================================================================
檔案代號:glfe_t
檔案名稱:財務指標公式設定維護單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glfe_t
(
glfeent       number(5)      ,/* 企業編號 */
glfe001       varchar2(10)      ,/* 報表結構編號 */
glfeseq       number(10,0)      ,/* 項次 */
glfe002       number(10,0)      ,/* 報表序號 */
glfe003       varchar2(1)      ,/* 數據來源 */
glfe004       varchar2(10)      ,/* 指標編號 */
glfe005       varchar2(500)      ,/* 公式 */
glfe006       varchar2(1)      ,/* 資料格式 */
glfe007       number(5,0)      ,/* 保留位數 */
glfe008       varchar2(1)      ,/* 顯示圖示否 */
glfe009       varchar2(1)      ,/* 圖示選擇 */
glfe010       varchar2(1)      ,/* 比較值顯示否 */
glfe011       varchar2(1)      ,/* 圓盤顯示否 */
glfe012       number(15,3)      ,/* 優秀值 */
glfe013       number(15,3)      ,/* 良好值 */
glfe014       number(15,3)      ,/* 平均值 */
glfe015       number(15,3)      ,/* 較低值 */
glfe016       number(15,3)      ,/* 較差值 */
glfeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glfeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glfeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glfeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glfeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glfeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glfeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glfeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glfeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glfeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glfeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glfeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glfeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glfeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glfeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glfeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glfeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glfeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glfeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glfeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glfeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glfeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glfeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glfeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glfeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glfeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glfeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glfeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glfeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glfeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glfe_t add constraint glfe_pk primary key (glfeent,glfe001,glfeseq) enable validate;

create unique index glfe_pk on glfe_t (glfeent,glfe001,glfeseq);

grant select on glfe_t to tiptop;
grant update on glfe_t to tiptop;
grant delete on glfe_t to tiptop;
grant insert on glfe_t to tiptop;

exit;
