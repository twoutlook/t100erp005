/* 
================================================================================
檔案代號:stde_t
檔案名稱:內部結算明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table stde_t
(
stdeent       number(5)      ,/* 企業編號 */
stde001       varchar2(10)      ,/* 結算中心 */
stde002       number(10,0)      ,/* 結算會計期 */
stde003       varchar2(10)      ,/* 業務類型 */
stde004       varchar2(10)      ,/* 內部交易類型 */
stde005       date      ,/* 單據日期 */
stde006       varchar2(20)      ,/* 單據編號 */
stde007       number(10,0)      ,/* 項次 */
stde008       varchar2(40)      ,/* 產品編號 */
stde009       varchar2(40)      ,/* 產品條碼 */
stde010       varchar2(256)      ,/* 產品特徵 */
stde011       varchar2(10)      ,/* 單位 */
stde012       number(20,6)      ,/* 數量 */
stde013       varchar2(10)      ,/* 費用編號 */
stde014       varchar2(10)      ,/* 幣別 */
stde015       varchar2(10)      ,/* 稅別 */
stde016       number(20,6)      ,/* 單價 */
stde017       number(5,0)      ,/* 方向 */
stde018       number(20,6)      ,/* 未稅金額 */
stde019       number(20,6)      ,/* 含稅金額 */
stde020       varchar2(10)      ,/* 需求組織 */
stde021       varchar2(10)      ,/* 需求法人 */
stde022       varchar2(10)      ,/* 需求倉庫(入) */
stde023       varchar2(10)      ,/* 供貨組織 */
stde024       varchar2(10)      ,/* 供貨法人 */
stde025       varchar2(10)      ,/* 供貨倉庫(出） */
stde026       varchar2(10)      ,/* 配送組織 */
stde027       varchar2(10)      ,/* 配送法人 */
stde028       varchar2(10)      ,/* 流程代碼 */
stde029       varchar2(20)      ,/* 匯總單號 */
stde030       number(10,0)      ,/* 匯總項次 */
stdestus       varchar2(10)      ,/* 處理狀態 */
stdeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stdeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stdeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stdeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stdeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stdeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stdeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stdeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stdeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stdeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stdeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stdeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stdeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stdeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stdeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stdeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stdeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stdeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stdeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stdeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stdeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stdeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stdeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stdeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stdeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stdeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stdeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stdeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stdeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stdeud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
stde031       number(10,0)      /* 項序 */
);
alter table stde_t add constraint stde_pk primary key (stdeent,stde006,stde007,stde031) enable validate;

create unique index stde_pk on stde_t (stdeent,stde006,stde007,stde031);

grant select on stde_t to tiptop;
grant update on stde_t to tiptop;
grant delete on stde_t to tiptop;
grant insert on stde_t to tiptop;

exit;
