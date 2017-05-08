/* 
================================================================================
檔案代號:ecaa_t
檔案名稱:工作站基本資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ecaa_t
(
ecaaent       number(5)      ,/* 企業編號 */
ecaasite       varchar2(10)      ,/* 營運據點 */
ecaaownid       varchar2(20)      ,/* 資料所有者 */
ecaaowndp       varchar2(10)      ,/* 資料所屬部門 */
ecaacrtid       varchar2(20)      ,/* 資料建立者 */
ecaacrtdp       varchar2(10)      ,/* 資料建立部門 */
ecaacrtdt       timestamp(0)      ,/* 資料創建日 */
ecaamodid       varchar2(20)      ,/* 資料修改者 */
ecaamoddt       timestamp(0)      ,/* 最近修改日 */
ecaastus       varchar2(10)      ,/* 狀態碼 */
ecaa001       varchar2(10)      ,/* 工作站 */
ecaa002       varchar2(80)      ,/* 工作站名稱 */
ecaa003       varchar2(10)      ,/* 成本中心 */
ecaa004       varchar2(10)      ,/* 產能型態 */
ecaa005       varchar2(5)      ,/* 工作曆 */
ecaa006       number(15,3)      ,/* 每日人工產能 */
ecaa007       number(15,3)      ,/* 每日機器產能 */
ecaa008       number(20,6)      ,/* 標準人工效率 */
ecaa009       number(20,6)      ,/* 標準機器負荷 */
ecaa010       number(20,6)      ,/* 標準人工成本 */
ecaa011       number(20,6)      ,/* 標準製造費用 */
ecaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ecaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ecaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ecaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ecaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ecaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ecaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ecaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ecaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ecaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ecaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ecaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ecaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ecaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ecaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ecaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ecaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ecaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ecaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ecaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ecaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ecaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ecaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ecaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ecaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ecaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ecaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ecaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ecaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ecaaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ecaa_t add constraint ecaa_pk primary key (ecaaent,ecaasite,ecaa001) enable validate;

create unique index ecaa_pk on ecaa_t (ecaaent,ecaasite,ecaa001);

grant select on ecaa_t to tiptop;
grant update on ecaa_t to tiptop;
grant delete on ecaa_t to tiptop;
grant insert on ecaa_t to tiptop;

exit;
