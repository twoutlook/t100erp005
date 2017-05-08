/* 
================================================================================
檔案代號:psba_t
檔案名稱:MDS計算策略檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table psba_t
(
psbaent       number(5)      ,/* 企業編號 */
psba001       varchar2(10)      ,/* MDS編號 */
psba002       varchar2(1)      ,/* 需求來源-銷售預測 */
psba003       varchar2(1)      ,/* 需求來源-訂單 */
psba004       varchar2(1)      ,/* 需求來源-預先訂單 */
psba005       varchar2(1)      ,/* 需求來源-獨立需求 */
psba006       varchar2(10)      ,/* 需求滿足方式 */
psba007       varchar2(10)      ,/* 指定預測編號 */
psba008       varchar2(10)      ,/* 訂單與預測沖銷方式 */
psba009       varchar2(10)      ,/* 預測需求來源 */
psba010       number(5,0)      ,/* 預測無效天數 */
psba011       varchar2(1)      ,/* 逾期訂單是否納入 */
psba012       number(5,0)      ,/* 最長允許逾交天數 */
psba013       varchar2(10)      ,/* 單據順序1 */
psba014       varchar2(10)      ,/* 單據順序2 */
psba015       varchar2(10)      ,/* 單據順序3 */
psba016       varchar2(10)      ,/* 優先順序時距 */
psba017       varchar2(10)      ,/* 重要性順序1 */
psba018       varchar2(10)      ,/* 重要性順序2 */
psba019       varchar2(10)      ,/* 重要性順序3 */
psba020       varchar2(10)      ,/* 預測需求分攤方式 */
psba021       varchar2(10)      ,/* 數量進位方式 */
psba022       number(20,6)      ,/* 數量進位指定量 */
psba023       varchar2(10)      ,/* 餘量策略 */
psba024       number(20,6)      ,/* 工作日分攤比-星期一 */
psba025       number(20,6)      ,/* 工作日分攤比-星期二 */
psba026       number(20,6)      ,/* 工作日分攤比-星期三 */
psba027       number(20,6)      ,/* 工作日分攤比-星期四 */
psba028       number(20,6)      ,/* 工作日分攤比-星期五 */
psba029       number(20,6)      ,/* 工作日分攤比-星期六 */
psba030       number(20,6)      ,/* 工作日分攤比-星期日 */
psbaownid       varchar2(20)      ,/* 資料所有者 */
psbaowndp       varchar2(10)      ,/* 資料所屬部門 */
psbacrtid       varchar2(20)      ,/* 資料建立者 */
psbacrtdp       varchar2(10)      ,/* 資料建立部門 */
psbacrtdt       timestamp(0)      ,/* 資料創建日 */
psbamodid       varchar2(20)      ,/* 資料修改者 */
psbamoddt       timestamp(0)      ,/* 最近修改日 */
psbastus       varchar2(10)      ,/* 狀態碼 */
psbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
psba031       timestamp(0)      /* MDS計算日期時間 */
);
alter table psba_t add constraint psba_pk primary key (psbaent,psba001) enable validate;

create unique index psba_pk on psba_t (psbaent,psba001);

grant select on psba_t to tiptop;
grant update on psba_t to tiptop;
grant delete on psba_t to tiptop;
grant insert on psba_t to tiptop;

exit;
