/* 
================================================================================
檔案代號:qcbk_t
檔案名稱:Xbar-R管制資料單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table qcbk_t
(
qcbkent       number(5)      ,/* 企業編號 */
qcbksite       varchar2(10)      ,/* 營運據點 */
qcbk000       varchar2(10)      ,/* 檢驗類型 */
qcbk001       varchar2(20)      ,/* 檢驗單號 */
qcbk002       number(10,0)      ,/* 檢驗行序 */
qcbk003       varchar2(20)      ,/* 來源單號 */
qcbk004       number(10,0)      ,/* 來源單項次 */
qcbk005       varchar2(10)      ,/* 類型分類 */
qcbk006       varchar2(20)      ,/* 參考單號 */
qcbk007       number(10,0)      ,/* 參考項次 */
qcbk008       varchar2(40)      ,/* 料件編號 */
qcbk009       varchar2(10)      ,/* 版本 */
qcbk010       varchar2(256)      ,/* 產品特徵 */
qcbk011       varchar2(10)      ,/* 檢驗項目 */
qcbk012       number(10,0)      ,/* 樣本數 */
qcbk013       number(10,0)      ,/* 組數 */
qcbk014       number(20,6)      ,/* Xbar合計 */
qcbk015       number(20,6)      ,/* R合計 */
qcbk016       number(20,6)      ,/* Xbar-CL */
qcbk017       number(20,6)      ,/* Xbar-UCL */
qcbk018       number(20,6)      ,/* Xbar-LCL */
qcbk019       number(20,6)      ,/* R-CL */
qcbk020       number(20,6)      ,/* R-UCL */
qcbk021       number(20,6)      ,/* R-LCL */
qcbk022       date      ,/* 檢驗期間-起始 */
qcbk023       date      ,/* 檢驗期間-截止 */
qcbkownid       varchar2(20)      ,/* 資料所有者 */
qcbkowndp       varchar2(10)      ,/* 資料所屬部門 */
qcbkcrtid       varchar2(20)      ,/* 資料建立者 */
qcbkcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcbkcrtdt       timestamp(0)      ,/* 資料創建日 */
qcbkmodid       varchar2(20)      ,/* 資料修改者 */
qcbkmoddt       timestamp(0)      ,/* 最近修改日 */
qcbkcnfid       varchar2(20)      ,/* 資料確認者 */
qcbkcnfdt       timestamp(0)      ,/* 資料確認日 */
qcbkstus       varchar2(10)      ,/* 狀態碼 */
qcbkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbk_t add constraint qcbk_pk primary key (qcbkent,qcbksite,qcbk001,qcbk002) enable validate;

create unique index qcbk_pk on qcbk_t (qcbkent,qcbksite,qcbk001,qcbk002);

grant select on qcbk_t to tiptop;
grant update on qcbk_t to tiptop;
grant delete on qcbk_t to tiptop;
grant insert on qcbk_t to tiptop;

exit;
