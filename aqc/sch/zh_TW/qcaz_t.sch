/* 
================================================================================
檔案代號:qcaz_t
檔案名稱:品質檢驗參照表資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table qcaz_t
(
qcazent       number(5)      ,/* 企業編號 */
qcaz001       varchar2(5)      ,/* 參照表編號 */
qcaz002       number(10,0)      ,/* 不良數基準分子-Crtical */
qcaz003       number(10,0)      ,/* 不良數基準分母-Crtical */
qcaz004       number(10,0)      ,/* 不良數基準分子-Major */
qcaz005       number(10,0)      ,/* 不良數基準分母-Major */
qcaz006       number(10,0)      ,/* 不良數基準分子-Minor */
qcaz007       number(10,0)      ,/* 不良數基準分母-Minor */
qcaz008       varchar2(1)      ,/* QC需管制承認文號 */
qcaz009       varchar2(1)      ,/* 啟動檢驗程度轉換規則 */
qcaz010       number(5,0)      ,/* 連續幾批中 */
qcaz011       number(5,0)      ,/* 有幾批退貨則由正常轉加嚴檢驗 */
qcaz012       number(5,0)      ,/* 連續幾批合格則由加嚴轉正常檢驗 */
qcaz013       number(5,0)      ,/* 連續幾批合格則由正常轉減量檢驗 */
qcaz014       number(5,0)      ,/* 連續幾批退貨則由減量轉正常檢驗 */
qcaz015       number(5,0)      ,/* 連續幾批減量合格則由減量轉免驗 */
qcaz016       number(5,0)      ,/* 連續幾批加嚴則由加嚴轉除名 */
qcaz017       varchar2(1)      ,/* 使用品質判定功能 */
qcaz018       varchar2(1)      ,/* 檢驗項目是否可人工新增 */
qcazownid       varchar2(20)      ,/* 資料所有者 */
qcazowndp       varchar2(10)      ,/* 資料所屬部門 */
qcazcrtid       varchar2(20)      ,/* 資料建立者 */
qcazcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcazcrtdt       timestamp(0)      ,/* 資料創建日 */
qcazmodid       varchar2(20)      ,/* 資料修改者 */
qcazmoddt       timestamp(0)      ,/* 最近修改日 */
qcazstus       varchar2(10)      ,/* 狀態碼 */
qcazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcazud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcaz_t add constraint qcaz_pk primary key (qcazent,qcaz001) enable validate;

create unique index qcaz_pk on qcaz_t (qcazent,qcaz001);

grant select on qcaz_t to tiptop;
grant update on qcaz_t to tiptop;
grant delete on qcaz_t to tiptop;
grant insert on qcaz_t to tiptop;

exit;
