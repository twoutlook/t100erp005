/* 
================================================================================
檔案代號:xcbj_t
檔案名稱:工時費用統計維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcbj_t
(
xcbjent       number(5)      ,/* 企業編號 */
xcbjcomp       varchar2(10)      ,/* 法人組織 */
xcbjld       varchar2(5)      ,/* 帳別編號 */
xcbj001       varchar2(10)      ,/* 成本計算類型 */
xcbj002       number(5,0)      ,/* 年度 */
xcbj003       number(5,0)      ,/* 期別 */
xcbj004       varchar2(10)      ,/* 成本中心 */
xcbj005       varchar2(1)      ,/* 費用分類（主成本要素） */
xcbj006       varchar2(1)      ,/* 分攤方式 */
xcbj010       varchar2(1)      ,/* 制費類別 */
xcbj011       varchar2(24)      ,/* 會計科目 */
xcbj020       number(20,6)      ,/* 分攤基礎指標總和 */
xcbj021       number(20,6)      ,/* 標準產能 */
xcbj101       number(20,6)      ,/* 費用總額(本位幣一) */
xcbj102       number(20,6)      ,/* 固定費用(本位幣一) */
xcbj103       number(20,6)      ,/* 分攤金額(本位幣一) */
xcbj104       number(20,6)      ,/* 閒置費用(本位幣一) */
xcbj105       number(20,6)      ,/* 單位成本(本位幣一) */
xcbj111       number(20,6)      ,/* 費用總額(本位幣二) */
xcbj112       number(20,6)      ,/* 固定費用(本位幣二) */
xcbj113       number(20,6)      ,/* 分攤金額(本位幣二) */
xcbj114       number(20,6)      ,/* 閒置費用(本位幣二) */
xcbj115       number(20,6)      ,/* 單位成本(本位幣二) */
xcbj121       number(20,6)      ,/* 費用總額(本位幣三) */
xcbj122       number(20,6)      ,/* 固定費用(本位幣三) */
xcbj123       number(20,6)      ,/* 分攤金額(本位幣三) */
xcbj124       number(20,6)      ,/* 閒置費用(本位幣三) */
xcbj125       number(20,6)      ,/* 單位成本(本位幣三) */
xcbjownid       varchar2(20)      ,/* 資料所有者 */
xcbjowndp       varchar2(10)      ,/* 資料所屬部門 */
xcbjcrtid       varchar2(20)      ,/* 資料建立者 */
xcbjcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcbjcrtdt       timestamp(0)      ,/* 資料創建日 */
xcbjmodid       varchar2(20)      ,/* 資料修改者 */
xcbjmoddt       timestamp(0)      ,/* 最近修改日 */
xcbjstus       varchar2(10)      ,/* 狀態碼 */
xcbjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcbjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcbjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcbjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcbjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcbjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcbjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcbjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcbjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcbjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcbjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcbjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcbjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcbjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcbjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcbjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcbjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcbjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcbjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcbjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcbjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcbjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcbjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcbjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcbjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcbjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcbjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcbjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcbjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcbjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcbj_t add constraint xcbj_pk primary key (xcbjent,xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,xcbj006) enable validate;

create unique index xcbj_pk on xcbj_t (xcbjent,xcbjld,xcbj001,xcbj002,xcbj003,xcbj004,xcbj005,xcbj006);

grant select on xcbj_t to tiptop;
grant update on xcbj_t to tiptop;
grant delete on xcbj_t to tiptop;
grant insert on xcbj_t to tiptop;

exit;
