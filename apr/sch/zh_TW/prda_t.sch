/* 
================================================================================
檔案代號:prda_t
檔案名稱:促銷規則申請單頭資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prda_t
(
prdaent       number(5)      ,/* 企業編號 */
prdaunit       varchar2(10)      ,/* 應用組織 */
prdasite       varchar2(10)      ,/* 營運據點 */
prdadocno       varchar2(20)      ,/* 促銷申請單號 */
prdadocdt       date      ,/* 申請日期 */
prda000       varchar2(10)      ,/* 申請類型 */
prda001       varchar2(20)      ,/* 規則編號 */
prda002       varchar2(10)      ,/* 規則版本 */
prda003       varchar2(10)      ,/* 規則類型 */
prda004       varchar2(20)      ,/* 申請人員 */
prda005       varchar2(10)      ,/* 申請部門 */
prda006       varchar2(30)      ,/* 促銷方案 */
prda007       varchar2(30)      ,/* 活動計劃 */
prda008       varchar2(10)      ,/* 檔期類型 */
prda009       varchar2(10)      ,/* 活動等級 */
prda010       varchar2(1)      ,/* 全場促銷 */
prda011       varchar2(1)      ,/* 款別限制 */
prda012       varchar2(1)      ,/* 折扣卡 */
prda013       varchar2(1)      ,/* 日期高階設定 */
prda014       number(10,0)      ,/* 組合總額/量 */
prda015       varchar2(1)      ,/* 滿額分段否 */
prda016       varchar2(1)      ,/* 參加換贈 */
prda017       varchar2(10)      ,/* 換贈方式 */
prda018       varchar2(10)      ,/* 計算方式 */
prda019       varchar2(1)      ,/* 換贈設定模式 */
prda020       varchar2(1)      ,/* 兼容換贈 */
prda021       varchar2(10)      ,/* 換贈商品條件 */
prda022       number(5,0)      ,/* 限定換贈種類 */
prda023       number(5,0)      ,/* 限定換贈總數 */
prda024       varchar2(10)      ,/* 促銷方式 */
prda025       varchar2(10)      ,/* 入機方式 */
prda026       varchar2(10)      ,/* 參與對象 */
prda027       varchar2(40)      ,/* 促銷優先級 */
prda028       varchar2(10)      ,/* 返利標準 */
prda029       number(20,6)      ,/* 達成任務量返利率 */
prda030       number(20,6)      ,/* 超出任務量返利率 */
prda031       number(20,6)      ,/* 承擔比例 */
prda032       varchar2(10)      ,/* 物返方式 */
prda098       varchar2(10)      ,/* 應用業態 */
prdastus       varchar2(10)      ,/* 狀態碼 */
prdaownid       varchar2(20)      ,/* 資料所有者 */
prdaowndp       varchar2(10)      ,/* 資料所有部門 */
prdacrtid       varchar2(20)      ,/* 資料建立者 */
prdacrtdp       varchar2(10)      ,/* 資料建立部門 */
prdacrtdt       timestamp(0)      ,/* 資料創建日 */
prdamodid       varchar2(20)      ,/* 資料修改者 */
prdamoddt       timestamp(0)      ,/* 最近修改日 */
prdacnfid       varchar2(20)      ,/* 資料確認者 */
prdacnfdt       timestamp(0)      ,/* 資料確認日 */
prdaacti       varchar2(10)      ,/* 資料有效否 */
prdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prdaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
prda033       varchar2(10)      ,/* 活動類型 */
prda034       varchar2(1)      ,/* 是否列印 */
prda101       varchar2(10)      ,/* 來源類型 */
prda102       varchar2(20)      ,/* 來源單號 */
prda037       number(5,0)      ,/* 會員總達成次數 */
prda038       varchar2(1)      ,/* 疊加否 */
prda103       varchar2(10)      ,/* 來源程式 */
prda039       varchar2(10)      ,/* 高階優惠方式 */
prda040       varchar2(10)      ,/* 換贈依會員折扣後金額 */
prda041       varchar2(10)      ,/* 換贈累計方式 */
prda042       varchar2(1)      /* 當天銷售積分否 */
);
alter table prda_t add constraint prda_pk primary key (prdaent,prdadocno) enable validate;

create unique index prda_pk on prda_t (prdaent,prdadocno);

grant select on prda_t to tiptop;
grant update on prda_t to tiptop;
grant delete on prda_t to tiptop;
grant insert on prda_t to tiptop;

exit;
