/* 
================================================================================
檔案代號:rtbc_t
檔案名稱:門店資訊准入檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtbc_t
(
rtbcent       number(5)      ,/* 企業編號 */
rtbcsite       varchar2(10)      ,/* 營運據點 */
rtbcunit       varchar2(10)      ,/* 應用組織 */
rtbcdocno       varchar2(20)      ,/* 申請單號 */
rtbcdocdt       date      ,/* 申請日期 */
rtbc000       varchar2(10)      ,/* 申請類別 */
rtbc001       varchar2(10)      ,/* 門店編號 */
rtbc002       varchar2(20)      ,/* 統一編號 */
rtbc003       varchar2(1)      ,/* 法人否 */
rtbc004       varchar2(5)      ,/* 單據別參照表號 */
rtbc005       varchar2(5)      ,/* 單據據點編號 */
rtbc006       varchar2(10)      ,/* 所屬國家地區 */
rtbc007       varchar2(10)      ,/* 上市櫃公司編號 */
rtbc008       varchar2(5)      ,/* 行事曆參照表號 */
rtbc009       varchar2(10)      ,/* 製造行事曆對應類別 */
rtbc010       varchar2(10)      ,/* 辦公行事曆對應類別 */
rtbc011       varchar2(10)      ,/* 專屬國家地區功能 */
rtbc012       varchar2(20)      ,/* 聯絡對象識別碼 */
rtbc013       varchar2(10)      ,/* 日期顯示格式 */
rtbc014       varchar2(5)      ,/* 幣別參照表號 */
rtbc015       varchar2(5)      ,/* 匯率參照表號 */
rtbc016       varchar2(10)      ,/* 主幣別編號 */
rtbc017       varchar2(10)      ,/* 法人歸屬 */
rtbc018       varchar2(10)      ,/* 時區 */
rtbc019       varchar2(10)      ,/* 稅區 */
rtbc020       varchar2(20)      ,/* 工商登記號 */
rtbc021       varchar2(80)      ,/* 法人代表 */
rtbc022       varchar2(80)      ,/* 註冊資本 */
rtbc023       varchar2(10)      ,/* 數字/金額顯示格式 */
rtbc024       varchar2(10)      ,/* 據點對應客戶/供應商編號 */
rtbc025       varchar2(5)      ,/* 品管參照表號 */
rtbc026       varchar2(15)      ,/* 預設存款銀行帳戶 */
rtbc100       varchar2(10)      ,/* 門店狀態 */
rtbc101       varchar2(10)      ,/* 層級類型 */
rtbc102       varchar2(10)      ,/* 業態 */
rtbc103       varchar2(10)      ,/* 通路 */
rtbc104       varchar2(10)      ,/* 商圈 */
rtbc105       varchar2(10)      ,/* 可比店 */
rtbc106       varchar2(10)      ,/* 價格參考標準 */
rtbc107       varchar2(255)      ,/* 店慶會計期 */
rtbc108       varchar2(10)      ,/* 散客編號 */
rtbc109       date      ,/* 開業日期 */
rtbc110       date      ,/* 閉店日期 */
rtbc111       number(20,6)      ,/* 測量面積 */
rtbc112       number(20,6)      ,/* 建築面積 */
rtbc113       number(20,6)      ,/* 經營面積 */
rtbc114       number(5,0)      ,/* 合作對象總數 */
rtbc115       varchar2(1)      ,/* 24小時營業否 */
rtbc120       number(20,6)      ,/* 本店取貨訂定比例 */
rtbc121       number(20,6)      ,/* 異店取貨訂定比例 */
rtbc122       number(20,6)      ,/* 總部配送訂定比例 */
rtbc123       varchar2(10)      ,/* 預設收貨倉 */
rtbc124       varchar2(10)      ,/* 預設出貨倉 */
rtbc125       varchar2(10)      ,/* 預設在途倉 */
rtbc150       varchar2(10)      ,/* 門店類別 */
rtbc151       varchar2(10)      ,/* 規模類別 */
rtbc152       varchar2(10)      ,/* 門店週期 */
rtbc153       varchar2(10)      ,/* 銷售區域 */
rtbc154       varchar2(10)      ,/* 銷售省區 */
rtbc155       varchar2(10)      ,/* 銷售地區 */
rtbc156       varchar2(10)      ,/* 銷售片區 */
rtbc157       varchar2(10)      ,/* 其他屬性1 */
rtbc158       varchar2(10)      ,/* 其他屬性2 */
rtbc159       varchar2(10)      ,/* 其他屬性3 */
rtbc160       varchar2(10)      ,/* 其他屬性4 */
rtbc161       varchar2(10)      ,/* 其他屬性5 */
rtbc162       varchar2(10)      ,/* 其他屬性6 */
rtbc163       varchar2(10)      ,/* 其他屬性7 */
rtbc164       varchar2(10)      ,/* 其他屬性8 */
rtbc165       varchar2(10)      ,/* 其他屬性9 */
rtbc166       varchar2(10)      ,/* 其他屬性10 */
rtbcstus       varchar2(10)      ,/* 狀態碼 */
rtbcownid       varchar2(20)      ,/* 資料所有者 */
rtbcowndp       varchar2(10)      ,/* 資料所有部門 */
rtbccrtid       varchar2(20)      ,/* 資料建立者 */
rtbccrtdp       varchar2(10)      ,/* 資料建立部門 */
rtbccrtdt       timestamp(0)      ,/* 資料創建日 */
rtbcmodid       varchar2(20)      ,/* 資料修改者 */
rtbcmoddt       timestamp(0)      ,/* 最近修改日 */
rtbccnfid       varchar2(20)      ,/* 資料確認者 */
rtbccnfdt       timestamp(0)      ,/* 資料確認日 */
rtbcacti       varchar2(1)      ,/* 資料有效碼 */
rtbcud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbcud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbcud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbcud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbcud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbcud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbcud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbcud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbcud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbcud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbcud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbcud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbcud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbcud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbcud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbcud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbcud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbcud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbcud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbcud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbcud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbcud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbcud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbcud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbcud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbcud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbcud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbcud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbcud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbcud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
rtbc116       varchar2(10)      ,/* 語言別 */
rtbc126       varchar2(10)      ,/* 預設收貨非成本倉 */
rtbc127       varchar2(10)      ,/* 預設出貨非成本倉 */
rtbc128       varchar2(10)      /* 預設在途非成本倉 */
);
alter table rtbc_t add constraint rtbc_pk primary key (rtbcent,rtbcdocno) enable validate;

create unique index rtbc_pk on rtbc_t (rtbcent,rtbcdocno);

grant select on rtbc_t to tiptop;
grant update on rtbc_t to tiptop;
grant delete on rtbc_t to tiptop;
grant insert on rtbc_t to tiptop;

exit;
