/* 
================================================================================
檔案代號:psja_t
檔案名稱:採購預測策略檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table psja_t
(
psjaent       number(5)      ,/* 企業編號 */
psjasite       varchar2(10)      ,/* 營運據點 */
psja001       varchar2(10)      ,/* 預測編號 */
psja002       number(5,0)      ,/* 預測期數 */
psja003       number(5,0)      ,/* 預測起始日 */
psja004       varchar2(10)      ,/* APS版本 */
psja005       varchar2(1)      ,/* 依計畫員預測 */
psja006       varchar2(10)      ,/* 供應商分配方式 */
psja007       varchar2(10)      ,/* 指定供應商 */
psja008       number(20,6)      ,/* 分配限量 */
psjaownid       varchar2(20)      ,/* 資料所有者 */
psjaowndp       varchar2(10)      ,/* 資料所屬部門 */
psjacrtid       varchar2(20)      ,/* 資料建立者 */
psjacrtdp       varchar2(10)      ,/* 資料建立部門 */
psjacrtdt       timestamp(0)      ,/* 資料創建日 */
psjamodid       varchar2(20)      ,/* 資料修改者 */
psjamoddt       timestamp(0)      ,/* 最近修改日 */
psjastus       varchar2(10)      ,/* 狀態碼 */
psjaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psjaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psjaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psjaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psjaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psjaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psjaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psjaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psjaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psjaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psjaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psjaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psjaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psjaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psjaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psjaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psjaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psjaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psjaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psjaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psjaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psjaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psjaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psjaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psjaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psjaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psjaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psjaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psjaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psjaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table psja_t add constraint psja_pk primary key (psjaent,psjasite,psja001) enable validate;

create unique index psja_pk on psja_t (psjaent,psjasite,psja001);

grant select on psja_t to tiptop;
grant update on psja_t to tiptop;
grant delete on psja_t to tiptop;
grant insert on psja_t to tiptop;

exit;
