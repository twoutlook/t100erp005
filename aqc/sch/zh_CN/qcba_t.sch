/* 
================================================================================
檔案代號:qcba_t
檔案名稱:品質檢驗單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table qcba_t
(
qcbaent       number(5)      ,/* 企業編號 */
qcbasite       varchar2(10)      ,/* 營運據點 */
qcbadocno       varchar2(20)      ,/* 單號 */
qcbadocdt       date      ,/* 單據日期 */
qcba000       varchar2(10)      ,/* 檢驗類型 */
qcba001       varchar2(20)      ,/* 來源單號 */
qcba002       number(10,0)      ,/* 來源單項次 */
qcba003       varchar2(20)      ,/* 參考單號 */
qcba004       number(10,0)      ,/* 參考單項次 */
qcba005       varchar2(10)      ,/* 交易對象編號 */
qcba006       varchar2(10)      ,/* 作業編號 */
qcba007       number(10,0)      ,/* 加工序 */
qcba008       number(20,6)      ,/* 來源數量 */
qcba009       varchar2(10)      ,/* 單位 */
qcba010       varchar2(40)      ,/* 料件編號 */
qcba011       varchar2(10)      ,/* 版本 */
qcba012       varchar2(256)      ,/* 產品特徵 */
qcba013       varchar2(10)      ,/* 品管分群 */
qcba014       date      ,/* 檢驗日期 */
qcba015       varchar2(8)      ,/* 檢驗時間 */
qcba016       varchar2(10)      ,/* 檢驗單位 */
qcba017       number(20,6)      ,/* 送驗量 */
qcba018       varchar2(10)      ,/* 檢驗程度 */
qcba019       varchar2(10)      ,/* 檢驗級數 */
qcba020       varchar2(20)      ,/* 承認文號 */
qcba021       varchar2(10)      ,/* 緊急度 */
qcba022       varchar2(10)      ,/* 判定結果 */
qcba023       number(20,6)      ,/* 合格量 */
qcba024       varchar2(20)      ,/* 檢驗員 */
qcba030       varchar2(20)      ,/* 檢驗項目識別碼 */
qcba900       varchar2(20)      ,/* 開單人員 */
qcba901       varchar2(10)      ,/* 開單部門 */
qcbaownid       varchar2(20)      ,/* 資料所有者 */
qcbaowndp       varchar2(10)      ,/* 資料所屬部門 */
qcbacrtid       varchar2(20)      ,/* 資料建立者 */
qcbacrtdp       varchar2(10)      ,/* 資料建立部門 */
qcbacrtdt       timestamp(0)      ,/* 資料創建日 */
qcbamodid       varchar2(20)      ,/* 資料修改者 */
qcbamoddt       timestamp(0)      ,/* 最近修改日 */
qcbacnfid       varchar2(20)      ,/* 資料確認者 */
qcbacnfdt       timestamp(0)      ,/* 資料確認日 */
qcbapstid       varchar2(20)      ,/* 資料過帳者 */
qcbapstdt       timestamp(0)      ,/* 資料過帳日 */
qcbastus       varchar2(10)      ,/* 狀態碼 */
qcba025       varchar2(8)      ,/* 完成檢驗時間 */
qcba026       number(10,0)      ,/* 檢驗時間 */
qcba027       number(20,6)      ,/* 不良數 */
qcbaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
qcba028       date      ,/* 完成檢驗日期 */
qcba031       varchar2(10)      ,/* 類型分類 */
qcba029       number(10,0)      ,/* RunCard */
qcba032       varchar2(20)      ,/* 品質異常申請單號 */
qcba033       varchar2(20)      /* 電子質檢單號 */
);
alter table qcba_t add constraint qcba_pk primary key (qcbaent,qcbadocno) enable validate;

create  index qcba_01 on qcba_t (qcba030);
create unique index qcba_pk on qcba_t (qcbaent,qcbadocno);

grant select on qcba_t to tiptop;
grant update on qcba_t to tiptop;
grant delete on qcba_t to tiptop;
grant insert on qcba_t to tiptop;

exit;
