/* 
================================================================================
檔案代號:xcba_t
檔案名稱:成本要素分攤設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcba_t
(
xcbaent       number(5)      ,/* 企業編號 */
xcbaownid       varchar2(20)      ,/* 資料所有者 */
xcbaowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbacrtid       varchar2(20)      ,/* 資料建立者 */
xcbacrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbacrtdt       timestamp(0)      ,/* 資料創建日 */
xcbamodid       varchar2(20)      ,/* 資料修改者 */
xcbamoddt       timestamp(0)      ,/* 最近修改日 */
xcbastus       varchar2(10)      ,/* 狀態碼 */
xcbald       varchar2(5)      ,/* 帳別 */
xcba001       varchar2(1)      ,/* 分攤類型 */
xcba002       number(5,0)      ,/* 年度 */
xcba003       number(5,0)      ,/* 期別 */
xcba004       varchar2(10)      ,/* 成本中心 */
xcba005       varchar2(24)      ,/* 科目編號 */
xcba006       varchar2(10)      ,/* 部門編號 */
xcba007       varchar2(1)      ,/* 分攤公式 */
xcba008       varchar2(1)      ,/* 部門屬性 */
xcba009       number(20,6)      ,/* 分攤權數 */
xcbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcba_t add constraint xcba_pk primary key (xcbaent,xcbald,xcba001,xcba002,xcba003,xcba004,xcba005,xcba006) enable validate;

create unique index xcba_pk on xcba_t (xcbaent,xcbald,xcba001,xcba002,xcba003,xcba004,xcba005,xcba006);

grant select on xcba_t to tiptop;
grant update on xcba_t to tiptop;
grant delete on xcba_t to tiptop;
grant insert on xcba_t to tiptop;

exit;
