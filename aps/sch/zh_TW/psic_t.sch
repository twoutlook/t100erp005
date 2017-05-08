/* 
================================================================================
檔案代號:psic_t
檔案名稱:採購預測其他資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table psic_t
(
psicent       number(5)      ,/* 企業編號 */
psicsite       varchar2(10)      ,/* 營運據點 */
psic001       varchar2(10)      ,/* 預測編號 */
psic002       date      ,/* 預測起始日期 */
psic003       varchar2(10)      ,/* 供應商 */
psic004       varchar2(20)      ,/* 計畫員 */
psic005       varchar2(10)      ,/* 版本 */
psic006       varchar2(40)      ,/* 料件編號 */
psic007       varchar2(256)      ,/* 產品特徵 */
psic008       varchar2(1)      ,/* 保稅否 */
psic009       number(20,6)      ,/* 庫存量 */
psic010       number(20,6)      ,/* 請購量 */
psic011       number(20,6)      ,/* 採購未收量 */
psic012       number(20,6)      ,/* 採購在驗量 */
psicownid       varchar2(20)      ,/* 資料所有者 */
psicowndp       varchar2(10)      ,/* 資料所屬部門 */
psiccrtid       varchar2(20)      ,/* 資料建立者 */
psiccrtdp       varchar2(10)      ,/* 資料建立部門 */
psiccrtdt       timestamp(0)      ,/* 資料創建日 */
psicmodid       varchar2(20)      ,/* 資料修改者 */
psicmoddt       timestamp(0)      ,/* 最近修改日 */
psiccnfid       varchar2(20)      ,/* 資料確認者 */
psiccnfdt       timestamp(0)      ,/* 資料確認日 */
psicpstid       varchar2(20)      ,/* 資料過帳者 */
psicpstdt       timestamp(0)      ,/* 資料過帳日 */
psicstus       varchar2(10)      ,/* 狀態碼 */
psicud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
psicud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
psicud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
psicud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
psicud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
psicud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
psicud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
psicud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
psicud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
psicud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
psicud011       number(20,6)      ,/* 自定義欄位(數字)011 */
psicud012       number(20,6)      ,/* 自定義欄位(數字)012 */
psicud013       number(20,6)      ,/* 自定義欄位(數字)013 */
psicud014       number(20,6)      ,/* 自定義欄位(數字)014 */
psicud015       number(20,6)      ,/* 自定義欄位(數字)015 */
psicud016       number(20,6)      ,/* 自定義欄位(數字)016 */
psicud017       number(20,6)      ,/* 自定義欄位(數字)017 */
psicud018       number(20,6)      ,/* 自定義欄位(數字)018 */
psicud019       number(20,6)      ,/* 自定義欄位(數字)019 */
psicud020       number(20,6)      ,/* 自定義欄位(數字)020 */
psicud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
psicud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
psicud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
psicud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
psicud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
psicud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
psicud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
psicud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
psicud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
psicud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
psic013       number(20,6)      /* 未分配量 */
);
alter table psic_t add constraint psic_pk primary key (psicent,psicsite,psic001,psic002,psic003,psic004,psic005,psic006,psic007,psic008) enable validate;

create unique index psic_pk on psic_t (psicent,psicsite,psic001,psic002,psic003,psic004,psic005,psic006,psic007,psic008);

grant select on psic_t to tiptop;
grant update on psic_t to tiptop;
grant delete on psic_t to tiptop;
grant insert on psic_t to tiptop;

exit;
