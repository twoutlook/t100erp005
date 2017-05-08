/* 
================================================================================
檔案代號:xcat_t
檔案名稱:成本類型設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcat_t
(
xcatent       number(5)      ,/* 企業編號 */
xcatownid       varchar2(20)      ,/* 資料所有者 */
xcatowndp       varchar2(10)      ,/* 資料所屬部門 */
xcatcrtid       varchar2(20)      ,/* 資料建立者 */
xcatcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcatcrtdt       timestamp(0)      ,/* 資料創建日 */
xcatmodid       varchar2(20)      ,/* 資料修改者 */
xcatmoddt       timestamp(0)      ,/* 最近修改日 */
xcatstus       varchar2(10)      ,/* 狀態碼 */
xcat001       varchar2(10)      ,/* 成本類型編號 */
xcat002       varchar2(1)      ,/* 計算方式 */
xcat003       varchar2(1)      ,/* 計算時點 */
xcat004       varchar2(1)      ,/* 成本要素 */
xcat005       varchar2(1)      ,/* 計價方式 */
xcatud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcatud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcatud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcatud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcatud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcatud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcatud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcatud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcatud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcatud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcatud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcatud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcatud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcatud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcatud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcatud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcatud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcatud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcatud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcatud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcatud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcatud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcatud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcatud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcatud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcatud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcatud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcatud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcatud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcatud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcat_t add constraint xcat_pk primary key (xcatent,xcat001) enable validate;

create unique index xcat_pk on xcat_t (xcatent,xcat001);

grant select on xcat_t to tiptop;
grant update on xcat_t to tiptop;
grant delete on xcat_t to tiptop;
grant insert on xcat_t to tiptop;

exit;
