/* 
================================================================================
檔案代號:xmen_t
檔案名稱:派車單單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table xmen_t
(
xmenent       number(5)      ,/* 企業編號 */
xmensite       varchar2(10)      ,/* 營運據點 */
xmendocno       varchar2(20)      ,/* 派車單單號 */
xmendocdt       date      ,/* 單據日期 */
xmen001       date      ,/* 出車日 */
xmen002       varchar2(20)      ,/* 派車人員 */
xmen003       varchar2(10)      ,/* 部門 */
xmen004       varchar2(10)      ,/* 運輸廠商 */
xmen005       varchar2(20)      ,/* 車輛編號 */
xmen006       varchar2(20)      ,/* 拖車編號 */
xmen007       varchar2(20)      ,/* 駕駛員 */
xmen008       varchar2(20)      ,/* 隨車員一 */
xmen009       varchar2(20)      ,/* 隨車員二 */
xmen010       varchar2(20)      ,/* 隨車員三 */
xmen011       varchar2(10)      ,/* 廠牌 */
xmen012       varchar2(10)      ,/* 車款 */
xmen013       varchar2(10)      ,/* 類型 */
xmen014       varchar2(10)      ,/* 運費代號 */
xmen015       date      ,/* 預計返回日 */
xmen016       varchar2(10)      ,/* 派車原因 */
xmen017       varchar2(20)      ,/* 地磅單編號 */
xmen018       number(20,6)      ,/* 理論總重量 */
xmen019       number(20,6)      ,/* 實際重量 */
xmen020       number(20,6)      ,/* 差異重量 */
xmen021       varchar2(255)      ,/* 備註 */
xmenownid       varchar2(20)      ,/* 資料所有者 */
xmenowndp       varchar2(10)      ,/* 資料所屬部門 */
xmencrtid       varchar2(20)      ,/* 資料建立者 */
xmencrtdp       varchar2(10)      ,/* 資料建立部門 */
xmencrtdt       timestamp(0)      ,/* 資料創建日 */
xmenmodid       varchar2(20)      ,/* 資料修改者 */
xmenmoddt       timestamp(0)      ,/* 最近修改日 */
xmencnfid       varchar2(20)      ,/* 資料確認者 */
xmencnfdt       timestamp(0)      ,/* 資料確認日 */
xmenpstid       varchar2(20)      ,/* 資料過帳者 */
xmenpstdt       timestamp(0)      ,/* 資料過帳日 */
xmenstus       varchar2(10)      ,/* 狀態碼 */
xmenud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xmenud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xmenud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xmenud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xmenud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xmenud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xmenud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xmenud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xmenud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xmenud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xmenud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xmenud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xmenud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xmenud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xmenud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xmenud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xmenud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xmenud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xmenud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xmenud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xmenud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xmenud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xmenud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xmenud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xmenud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xmenud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xmenud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xmenud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xmenud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xmenud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xmen_t add constraint xmen_pk primary key (xmenent,xmendocno) enable validate;

create unique index xmen_pk on xmen_t (xmenent,xmendocno);

grant select on xmen_t to tiptop;
grant update on xmen_t to tiptop;
grant delete on xmen_t to tiptop;
grant insert on xmen_t to tiptop;

exit;
