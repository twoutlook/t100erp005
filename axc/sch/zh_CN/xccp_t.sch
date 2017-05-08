/* 
================================================================================
檔案代號:xccp_t
檔案名稱:本期在製成本調整檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xccp_t
(
xccpent       number(5)      ,/* 企業編號 */
xccpld       varchar2(5)      ,/* 帳套 */
xccpcomp       varchar2(10)      ,/* 法人組織 */
xccp001       varchar2(1)      ,/* 帳套本位幣順序 */
xccp002       varchar2(30)      ,/* 成本域 */
xccp003       varchar2(10)      ,/* 成本計算類型 */
xccp004       number(5,0)      ,/* 年度 */
xccp005       number(5,0)      ,/* 期別 */
xccp006       varchar2(20)      ,/* 調整單號 */
xccp007       varchar2(20)      ,/* 工單編號 */
xccp008       varchar2(1)      ,/* 調整類型 */
xccp009       varchar2(80)      ,/* 調整說明 */
xccp101       number(20,6)      ,/* 當月調整數量 */
xccp102       number(20,6)      ,/* 當月調整金額 */
xccp102a       number(20,6)      ,/* 當月調整金額-材料 */
xccp102b       number(20,6)      ,/* 當月調整金額-人工 */
xccp102c       number(20,6)      ,/* 當月調整金額-委外加工 */
xccp102d       number(20,6)      ,/* 當月調整金額-制費一 */
xccp102e       number(20,6)      ,/* 當月調整金額-制費二 */
xccp102f       number(20,6)      ,/* 當月調整金額-制費三 */
xccp102g       number(20,6)      ,/* 當月調整金額-制費四 */
xccp102h       number(20,6)      ,/* 當月調整金額-制費五 */
xccpownid       varchar2(20)      ,/* 資料所有者 */
xccpowndp       varchar2(10)      ,/* 資料所屬部門 */
xccpcrtid       varchar2(20)      ,/* 資料建立者 */
xccpcrtdp       varchar2(10)      ,/* 資料建立部門 */
xccpcrtdt       timestamp(0)      ,/* 資料創建日 */
xccpmodid       varchar2(20)      ,/* 資料修改者 */
xccpmoddt       timestamp(0)      ,/* 最近修改日 */
xccpcnfid       varchar2(20)      ,/* 資料確認者 */
xccpcnfdt       timestamp(0)      ,/* 資料確認日 */
xccppstid       varchar2(20)      ,/* 資料過帳者 */
xccppstdt       timestamp(0)      ,/* 資料過帳日 */
xccpstus       varchar2(10)      ,/* 狀態碼 */
xccpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xccpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xccpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xccpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xccpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xccpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xccpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xccpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xccpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xccpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xccpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xccpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xccpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xccpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xccpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xccpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xccpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xccpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xccpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xccpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xccpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xccpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xccpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xccpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xccpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xccpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xccpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xccpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xccpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xccpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xccp_t add constraint xccp_pk primary key (xccpent,xccpld,xccp001,xccp003,xccp004,xccp005,xccp006,xccp007) enable validate;

create unique index xccp_pk on xccp_t (xccpent,xccpld,xccp001,xccp003,xccp004,xccp005,xccp006,xccp007);

grant select on xccp_t to tiptop;
grant update on xccp_t to tiptop;
grant delete on xccp_t to tiptop;
grant insert on xccp_t to tiptop;

exit;
